# frozen_string_literal: true

require "English"
require "fileutils"
require "logger"
require "json"
require "pathname"
require "securerandom"
require "yaml"

require_relative "glass_box/version"

module GlassBox
  ROOT = Pathname.new(__dir__).join("..").expand_path

  CHAT_KEYS = {
    openai: "OPENAI_API_KEY",
    anthropic: "ANTHROPIC_API_KEY",
    gemini: "GEMINI_API_KEY",
    openrouter: "OPENROUTER_API_KEY",
    xai: "XAI_API_KEY"
  }.freeze

  module_function

  def boot!
    return if @booted

    # Print each line as it is written, so output and errors stay in order
    # when a learner pipes a demo into a file or a pager.
    $stdout.sync = true
    require "dotenv"
    env_file = ROOT.join(".env")
    Dotenv.load(env_file) if env_file.file?

    require "ruby_llm"
    @offline = decide_offline
    configure!
    arm_offline_stub! if @offline
    explain_provider_errors_at_exit
    @booted = true
  end

  # When a provider rejects a request, Ruby would print a long backtrace. This
  # hook prints the error class, the provider's message and a next step, then
  # exits 1. Set RUBYLLM_DEBUG=true to see the backtrace.
  def explain_provider_errors_at_exit
    at_exit do
      error = $ERROR_INFO
      known = error.is_a?(RubyLLM::Error) || error.is_a?(RubyLLM::ConfigurationError)
      next unless known && ENV["RUBYLLM_DEBUG"] != "true"

      # exit! skips Ruby's own flush, so print what the demo wrote first.
      $stdout.flush
      warn provider_error_report(error)
      exit!(1)
    end
  end

  def provider_error_report(error)
    lines = ["", "The provider call failed.", "#{error.class}: #{mask_keys(error.message)}"]
    lines << case error
             when RubyLLM::UnauthorizedError
               "The provider rejected the API key. Check the key in .env, or set GLASS_BOX_MODE=offline."
             when RubyLLM::ConfigurationError
               "A provider this run needs has no key. Add the key to .env, or set GLASS_BOX_MODE=offline."
             else
               "Run again with GLASS_BOX_MODE=offline to use the scripted replies."
             end
    lines.join("\n")
  end

  # Provider error messages can quote part of the key that was sent.
  def mask_keys(text)
    text.to_s.gsub(/\b(sk|key|xai|gsk|AIza)[-_A-Za-z0-9*]{12,}/, "[key hidden]")
  end

  def offline?
    boot!
    @offline
  end

  def live?
    !offline?
  end

  def decide_offline
    mode = ENV["GLASS_BOX_MODE"].to_s.strip.downcase
    return true if %w[offline mock fixture].include?(mode)
    return false if mode == "live"

    CHAT_KEYS.values.none? { |key| present?(ENV[key]) } && !present?(ENV["GOOGLE_API_KEY"])
  end

  def present?(value)
    !value.to_s.strip.empty?
  end

  def configure!
    RubyLLM.configure do |config|
      assign_key(config, :openai_api_key, ENV["OPENAI_API_KEY"])
      assign_key(config, :anthropic_api_key, ENV["ANTHROPIC_API_KEY"])
      gemini = present?(ENV["GEMINI_API_KEY"]) ? ENV["GEMINI_API_KEY"] : ENV["GOOGLE_API_KEY"]
      assign_key(config, :gemini_api_key, gemini)
      assign_key(config, :openrouter_api_key, ENV["OPENROUTER_API_KEY"])
      assign_key(config, :xai_api_key, ENV["XAI_API_KEY"])
      assign_key(config, :cohere_api_key, ENV["COHERE_API_KEY"])
      assign_key(config, :mistral_api_key, ENV["MISTRAL_API_KEY"])
      assign_key(config, :typesafe_api_key, ENV["TYPESAFE_API_KEY"])
      assign_key(config, :elevenlabs_api_key, ENV["ELEVENLABS_API_KEY"])

      if @offline
        config.openai_api_key ||= "offline-not-a-real-key"
        config.anthropic_api_key ||= "offline-not-a-real-key"
        config.gemini_api_key ||= "offline-not-a-real-key"
        config.max_retries = 0
        config.request_timeout = 5
      end

      model, provider = preferred_model
      config.default_model = model if model
      config.logger = Logger.new($stdout) if ENV["RUBYLLM_DEBUG"] == "true"
      @default_provider = provider
    end
  end

  def assign_key(config, setter, value)
    config.public_send(:"#{setter}=", value) if present?(value)
  end

  def preferred_model
    if present?(ENV["RUBYLLM_MODEL"])
      return [ENV["RUBYLLM_MODEL"], ENV["RUBYLLM_PROVIDER"]&.strip&.downcase&.to_sym]
    end

    return ["gpt-6.1-sol", :openai] if present?(ENV["OPENAI_API_KEY"]) || @offline
    return ["claude-sonnet-5", :anthropic] if present?(ENV["ANTHROPIC_API_KEY"])
    return ["gemini-3.7-flash", :gemini] if present?(ENV["GEMINI_API_KEY"]) || present?(ENV["GOOGLE_API_KEY"])
    return ["grok-4", :xai] if present?(ENV["XAI_API_KEY"])
    return ["openai/gpt-4o-mini", :openrouter] if present?(ENV["OPENROUTER_API_KEY"])

    ["gpt-6.1-sol", :openai]
  end

  def default_provider
    boot!
    @default_provider
  end

  # The model and provider for an agent class. It returns the wanted pair when
  # that provider is configured, and the default chat model when it is not, so
  # a learner with one key can still run the agent demos in live mode.
  def model_for(model, provider)
    boot!
    return [model, provider] if provider_configured?(provider)

    preferred_model
  end

  def arm_offline_stub!
    require "ruby_llm/test_helper"
    RubyLLM::TestHelper::Script.stub(["(offline placeholder)"], { cost: nil, interval: nil })
  end

  # Queues scripted replies for the next chat requests. This does nothing in
  # live mode. interval: is the pause in seconds between streamed words.
  def script_replies(*replies, cost: 0.0042, interval: nil)
    boot!
    return unless offline?

    require "ruby_llm/test_helper"
    RubyLLM::TestHelper::Script.stub(replies, { cost: cost, interval: interval })
  end

  def mode_label
    offline? ? "offline (stub or fixture)" : "live provider"
  end

  def tool_call(name, **arguments)
    boot!
    require "ruby_llm/test_helper"
    RubyLLM::ToolCall.new(id: "call_#{SecureRandom.hex(4)}", name: name.to_s, arguments: arguments)
  end

  def catalog
    boot!
    @catalog ||= Catalog.load
  end

  def chat(model: nil, provider: nil)
    boot!
    model ||= preferred_model[0]
    provider = default_provider if provider.nil? && model == preferred_model[0]
    provider ? RubyLLM.chat(model: model, provider: provider) : RubyLLM.chat(model: model)
  end

  def provider_configured?(slug)
    boot!
    return true if offline?

    case slug.to_sym
    when :openai then present?(ENV["OPENAI_API_KEY"])
    when :anthropic then present?(ENV["ANTHROPIC_API_KEY"])
    when :gemini then present?(ENV["GEMINI_API_KEY"]) || present?(ENV["GOOGLE_API_KEY"])
    when :openrouter then present?(ENV["OPENROUTER_API_KEY"])
    when :xai then present?(ENV["XAI_API_KEY"])
    when :cohere then present?(ENV["COHERE_API_KEY"])
    when :mistral then present?(ENV["MISTRAL_API_KEY"])
    when :typesafe then present?(ENV["TYPESAFE_API_KEY"])
    when :elevenlabs then present?(ENV["ELEVENLABS_API_KEY"])
    when :bedrock
      present?(ENV["BEDROCK_API_KEY"]) && present?(ENV["BEDROCK_SECRET_KEY"]) && present?(ENV["BEDROCK_REGION"])
    else
      false
    end
  end

  def paid_media?
    ENV["GLASS_BOX_PAID_MEDIA"].to_s == "1"
  end

  def submit_batches?
    live? && ENV["GLASS_BOX_BATCH"].to_s == "1"
  end

  def approved?(prompt = "Approve this tool call? Type yes: ")
    choice = ENV["GLASS_BOX_APPROVE"].to_s.strip.downcase
    return choice == "yes" if %w[yes no].include?(choice)
    return false unless $stdin.tty?

    print prompt
    $stdin.gets.to_s.strip.downcase == "yes"
  end

  def output_dir(name)
    dir = ROOT.join("tmp/demos/#{name}")
    FileUtils.mkdir_p(dir)
    dir
  end

  def banner(title)
    boot!
    puts
    puts title
    puts "mode: #{mode_label}"
    puts "ruby_llm: #{RubyLLM::VERSION}"
    puts
  end

  def log(label, value)
    text = value.is_a?(String) ? value : value.inspect
    puts "[#{label}]"
    puts text
    puts
  end

  def watch(chat)
    chat.before_request { |payload| log("request", summarize_payload(payload)) }
    chat.before_tool_call { |call| log("tool call", "#{call.name} #{call.arguments.inspect}") }
    chat.after_tool_result { |result| log("tool result", result) }
    chat.after_fallback { |fallback| log("fallback", fallback.inspect) }
    chat
  end

  def summarize_payload(payload)
    return payload.inspect unless payload.is_a?(Hash)

    copy = JSON.parse(JSON.generate(redact(payload)))
    text = JSON.pretty_generate(copy)
    text.length > 2000 ? "#{text[0, 2000]}\n… truncated …" : text
  rescue JSON::GeneratorError, JSON::ParserError
    payload.keys.inspect
  end

  def redact(value)
    case value
    when Hash
      value.each_with_object({}) do |(key, inner), memo|
        memo[key] = if key.to_s =~ /key|authorization|secret|token/i
                      "[redacted]"
                    elsif inner.is_a?(String) && inner.length > 240
                      "#{inner[0, 80]}… (#{inner.bytesize} bytes)"
                    else
                      redact(inner)
                    end
      end
    when Array
      value.first(12).map { |inner| redact(inner) }
    else
      value
    end
  end

  def print_transcript(chat)
    puts "[transcript]"
    chat.messages.each { |message| print_message(message) }
  end

  def print_message(message)
    puts "role=#{message.role}"
    puts message.content.to_s unless message.content.to_s.empty?
    calls = message.respond_to?(:tool_calls) ? message.tool_calls : nil
    list = if calls.respond_to?(:each_value)
             calls.each_value.to_a
           elsif calls.respond_to?(:each)
             calls.to_a
           else
             []
           end
    list.each do |call|
      next unless call.respond_to?(:name)

      puts "tool_call #{call.name} #{call.arguments.inspect}"
    end
    puts
  end

  def print_cost(chat)
    total = chat.cost.total
    if total.nil?
      log("cost", "chat.cost.total is nil. The provider did not report a cost. A missing cost is not zero.")
    else
      log("cost", format("chat.cost.total = $%.4f", total))
    end
    total
  end

  def print_citations(response)
    citations = response.respond_to?(:citations) ? Array(response.citations) : []
    if citations.empty?
      log("citations", "response.citations is empty for this run.")
    else
      citations.each do |citation|
        log("citation", "#{citation.title} #{citation.cited_text}")
      end
    end
    citations
  end
end

require_relative "glass_box/fixtures"
require_relative "glass_box/catalog_server"
require_relative "glass_box/calls"
require_relative "glass_box/catalog"
require_relative "glass_box/sbpi"
require_relative "glass_box/trace"
