# frozen_string_literal: true

require_relative "../glass_box"

GlassBox.boot!
require "ruby_llm"

# Tools for the guided track. Names stay short so a stubbed tool call
# can use the same string the model would send.
class CatalogLookup < RubyLLM::Tool
  description "Look up a fictional title in the workshop catalog"

  def execute(name:)
    found = GlassBox.catalog.find_title(name)
    return { error: "not in the synthetic catalog" } unless found

    company, title = found
    {
      company: company.name,
      platform: company.platform,
      title: title.name,
      episodes: title.episodes,
      logline: title.logline
    }
  end
end

class CatalogNote < RubyLLM::Tool
  description "Record a note on a fictional title"
  requires_approval

  def execute(title:, note:)
    { recorded: true, title: title, note: note }
  end
end

class PublishScore < RubyLLM::Tool
  description "Publish a score card. The numbers come from the local scorer."
  requires_approval

  def execute(company:)
    row = GlassBox.catalog.find_company(company)
    return { error: "unknown company" } unless row

    { company: row.name, composite: row.composite, band: row.band }
  end
end

class ScorePublisher < RubyLLM::Agent
  # The tour's agent names claude-sonnet-5. Without an Anthropic key, a live
  # run uses the default chat model.
  agent_model, agent_provider = GlassBox.model_for("claude-sonnet-5", :anthropic)
  model agent_model, provider: agent_provider
  instructions "Publish a score card only by calling publish_score. Do not invent the composite."
  tools PublishScore
end

module GlassBox
  # Step runner for bin/learn. Each step applies one tour concept to the
  # fictional catalog. Ruby computes every composite. Wherever a reply states a
  # catalog fact, the prompt or a tool result supplies it, so a learner can
  # check a live reply.
  module Learn
    PROGRESS = ROOT.join("tmp/learn/progress.json")
    LESSONS = ROOT.join("guided/lessons")
    # Every lesson has these sections, in this order, above its Run section.
    LESSON_SECTIONS = ["## The concept", "## What this step does", "## What to look at"].freeze
    WRAP = 78

    STEPS = [
      { n: 1, slug: "01-curl-contrast", title: "A raw provider request next to RubyLLM", docs: "https://rubyllm.com/getting-started/" },
      { n: 2, slug: "02-chat-ask", title: "chat.ask starts a conversation", docs: "https://rubyllm.com/chat/" },
      { n: 3, slug: "03-conversation-memory", title: "The same chat remembers the last turn", docs: "https://rubyllm.com/chat/" },
      { n: 4, slug: "04-streaming", title: "Streaming tokens with a block", docs: "https://rubyllm.com/streaming/" },
      { n: 5, slug: "05-rails-turbo-stream", title: "Streaming a chat through a Rails job", docs: "https://rubyllm.com/rails-streaming/" },
      { n: 6, slug: "06-attachments", title: "Attachments: a path, a URL, and mixed files", docs: "https://rubyllm.com/attachments/" },
      { n: 7, slug: "07-tools-weather", title: "A Ruby tool the model can call", docs: "https://rubyllm.com/tools/" },
      { n: 8, slug: "08-mcp-linear", title: "An MCP server declared as a Ruby class", docs: "https://rubyllm.com/mcp/" },
      { n: 9, slug: "09-tool-search", title: "Tool search and an MCP App approval", docs: "https://rubyllm.com/tool-search/" },
      { n: 10, slug: "10-structured-output", title: "Structured output with a Schematist schema", docs: "https://rubyllm.com/structured-output/" },
      { n: 11, slug: "11-judgments", title: "Typed judgments with probabilities and choices", docs: "https://rubyllm.com/judgments/" },
      { n: 12, slug: "12-evaluations", title: "Evaluating an agent against a dataset", docs: "https://rubyllm.com/evaluations/" },
      { n: 13, slug: "13-opentelemetry", title: "Tracing a run with OpenTelemetry", docs: "https://rubyllm.com/opentelemetry/" },
      { n: 14, slug: "14-agents-approval-workflows", title: "An agent, a tool that needs approval, and a workflow", docs: "https://rubyllm.com/tool-execution/" },
      { n: 15, slug: "15-providers-one-api", title: "Nineteen providers, one Ruby API", docs: "https://rubyllm.com/models/" },
      { n: 16, slug: "16-speech-transcription", title: "Speech and transcription", docs: "https://rubyllm.com/text-to-speech/" },
      { n: 17, slug: "17-image-video-generation", title: "Image and video generation", docs: "https://rubyllm.com/image-generation/" },
      { n: 18, slug: "18-embeddings-rerank", title: "Embeddings and reranking", docs: "https://rubyllm.com/embeddings/" },
      { n: 19, slug: "19-ocr-moderation", title: "OCR and moderation", docs: "https://rubyllm.com/ocr/" },
      { n: 20, slug: "20-faster-by-default", title: "Faster by default in RubyLLM 2.1", docs: "https://rubyllm.com/whats-new-in-2-1/" },
      { n: 21, slug: "21-fallbacks-and-caching", title: "Model fallbacks and prompt caching", docs: "https://rubyllm.com/error-handling/" },
      { n: 22, slug: "22-thinking-and-provider-tools", title: "Extended thinking and provider web search", docs: "https://rubyllm.com/thinking/" },
      { n: 23, slug: "23-citations-and-cost", title: "Citations and cost tracking", docs: "https://rubyllm.com/citations/" },
      { n: 24, slug: "24-batches", title: "Batches of chats", docs: "https://rubyllm.com/batches/" },
      { n: 25, slug: "25-compaction-and-agentic-loop", title: "Compaction and the agentic loop", docs: "https://rubyllm.com/agentic-workflows/" },
      { n: 26, slug: "26-model-registry-and-tokens", title: "The model registry and token counting", docs: "https://rubyllm.com/models/" },
      { n: 27, slug: "27-closing", title: "Use Ruby", docs: "https://rubyllm.com/" }
    ].freeze

    module_function

    def status
      done = progress.fetch("completed")
      STEPS.each do |step|
        mark = done.include?(step[:n]) ? "done" : "    "
        puts format("%s  %02d  %s", mark, step[:n], step[:title])
      end
      puts "#{done.size} / #{STEPS.size} checkpoints in #{PROGRESS}"
    end

    def reset!
      FileUtils.rm_f(PROGRESS)
      puts "Cleared #{PROGRESS}"
    end

    def next!
      done = progress.fetch("completed")
      step = STEPS.find { |item| !done.include?(item[:n]) }
      if step.nil?
        puts "Every checkpoint is saved. bin/learn reset starts over."
        return true
      end

      run!(step[:n])
    end

    def auto!
      ENV["GLASS_BOX_APPROVE"] = "yes"
      STEPS.each do |step|
        next if run!(step[:n], teach: false)

        warn "bin/learn auto stopped at step #{step[:n]}. The later steps did not run."
        return false
      end
      true
    end

    def find_step(number)
      wanted = Integer(number.to_s, 10, exception: false)
      STEPS.find { |item| item[:n] == wanted }
    end

    # Prints the lesson, waits for Enter in a terminal, then runs the step.
    # bin/learn auto passes teach: false and prints only the step output.
    def run!(number, teach: true)
      step = find_step(number)
      if step.nil?
        warn "No step matches '#{number}'. The steps run from 1 to #{STEPS.size}."
        return false
      end

      puts
      puts "guided/#{format('%02d', step[:n])}  #{step[:title]}"
      puts "lesson: guided/lessons/#{step[:slug]}.md"
      puts "docs:   #{step[:docs]}"
      puts "demo:   bin/demo #{step[:n]}"
      puts "mode:   #{GlassBox.mode_label}"
      if teach
        puts
        puts lesson_for_terminal(step)
        puts
        wait_for_enter(step)
        puts "---- step #{step[:n]} output ----"
      end
      ok = begin
        send(:"step_#{format('%02d', step[:n])}")
      rescue RubyLLM::Error, RubyLLM::ConfigurationError => error
        raise if ENV["RUBYLLM_DEBUG"] == "true"

        warn GlassBox.provider_error_report(error)
        false
      end
      if ok == false
        puts "Checkpoint #{step[:n]} was not saved."
        return false
      end

      mark!(step[:n])
      puts "Checkpoint #{step[:n]} saved."
      true
    end

    def step_01
      company, title = GlassBox.catalog.find_title("The Last Lantern")
      question = prompt(1)
      body = {
        "model" => "gpt-5.6",
        "input" => question,
        "output" => [
          { "type" => "reasoning", "summary" => [] },
          {
            "type" => "message",
            "role" => "assistant",
            "content" => [{ "type" => "output_text", "text" => company.name }]
          }
        ]
      }
      message = body.fetch("output").find { |item| item["type"] == "message" }
      text = message.fetch("content").find { |part| part["type"] == "output_text" }.fetch("text")
      GlassBox.log "curl (not sent)", "POST /v1/responses  model=gpt-5.6  input=#{question.inspect}"
      GlassBox.log "assistant text from the nested output item", text
      puts "Read the output item whose type is message. output[0] is the reasoning item."
      puts "The catalog row for #{title.name} names #{company.name}."
      puts
      ask(question, text)
      true
    end

    def step_02
      title = GlassBox.catalog.find_title("The Last Lantern").last
      question = "#{prompt(2)} #{title.blurb.strip}"
      reply = "#{title.name} is a fictional Lantern serial of #{title.episodes} episodes. #{title.logline}"
      ask(question, reply)
      true
    end

    def step_03
      lantern = GlassBox.catalog.find_title("The Last Lantern")
      stall = GlassBox.catalog.find_title("Stall Seven")
      first = "#{prompt(3, 0)} #{lantern.last.blurb.strip}"
      second = "#{prompt(3, 1)} #{stall.last.blurb.strip}"
      GlassBox.script_replies(
        "#{lantern.last.name} has #{lantern.last.episodes} episodes on #{lantern.first.platform}.",
        "#{stall.last.name} has #{stall.last.episodes} episodes on #{stall.first.platform}. #{lantern.last.name} is the shorter serial.",
        cost: 0.0042
      ) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat)
      chat.ask first
      chat.ask second
      puts "messages the next request would carry:"
      chat.messages.each { |message| puts "  #{message.role}: #{message.content.to_s.tr("\n", " ")[0, 110]}" }
      puts
      GlassBox.print_cost(chat)
      true
    end

    def step_04
      dimension = GlassBox::SBPI.dimension("distribution_power")
      sentence = "#{dimension[:label]} is weighted #{dimension[:weight]} in this workshop score. It is the heaviest of the five."
      GlassBox.script_replies(sentence, cost: 0.001, interval: 0.04) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat)
      GlassBox.log "prompt", prompt(4)
      print "stream: "
      chat.ask(prompt(4)) { |chunk| print chunk.content }
      puts
      true
    end

    def step_05
      company = company_named("Lantern Reel")
      sentence = "#{company.name} has a composite of #{company.composite} in the #{company.band} band."
      puts "This step does not boot Rails. ruby_llm 2.2.3 generates ChatResponseJob, which calls chat.complete(&:broadcast)."
      puts "The tour showed ChatStreamJob and message.broadcast_append_chunk. Older generators wrote that method into the app."
      puts
      GlassBox.script_replies(sentence, cost: 0.001, interval: 0.04) unless GlassBox.live?
      chunks = []
      chat = GlassBox.chat
      GlassBox.log "prompt", prompt(5)
      chat.ask(prompt(5)) do |chunk|
        next if chunk.content.to_s.empty?

        chunks << chunk.content
        print chunk.content
      end
      puts
      GlassBox.log "chunks appended in memory", chunks.length
      true
    end

    def step_06
      require "marcel"
      path = ROOT.join("demos/fixtures/notes.txt")
      mime = Marcel::MimeType.for(path, name: "notes.txt")
      title = GlassBox.catalog.find_title("The Last Lantern").last
      question = prompt(6)
      reply = "#{title.name}, #{title.episodes} episodes."
      GlassBox.log "attached", "#{path} #{mime} bytes=#{File.size(path)}"
      puts "A URL attachment is valid in the API. This step does not fetch one."
      puts
      GlassBox.script_replies(reply, cost: 0.002) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat)
      GlassBox.log "prompt", question
      response = chat.ask(question, with: path.to_s)
      GlassBox.log "reply", response.content
      GlassBox.print_cost(chat)
      true
    end

    def step_07
      found = GlassBox.catalog.find_title("Salt Wedding")
      GlassBox.script_replies(
        GlassBox.tool_call(:catalog_lookup, name: "Salt Wedding"),
        "#{found.last.name} has #{found.last.episodes} episodes on #{found.first.name}.",
        cost: 0.002
      ) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat.with_tools(CatalogLookup))
      GlassBox.log "prompt", prompt(7)
      response = chat.ask prompt(7)
      GlassBox.log "reply", response.content
      GlassBox.print_transcript(chat)
      puts "Ruby lookup, same title: #{found.first.name}, #{found.last.episodes} episodes."
      true
    end

    def step_08
      unless defined?(WorkshopLinear)
        Object.const_set(:WorkshopLinear, Class.new(RubyLLM::MCP) do
          url "https://mcp.linear.app/mcp"
          inputs :user
          oauth owner: :user
          only :list_issues, :get_issue, :create_issue
          requires_approval :create_issue
          extension :apps
        end)
      end
      GlassBox.log "declared only", WorkshopLinear.only.inspect
      puts "WorkshopLinear is not connected. No request goes to mcp.linear.app."
      server = CatalogMCP.new(catalog: GlassBox.catalog)
      listed = server.list_titles(company: "Lantern Reel")
      GlassBox.log "local MCP list_titles", listed.text
      server.close
      true
    end

    def step_09
      GlassBox.script_replies(
        GlassBox.tool_call(:tool_search, query: "select:catalog_note"),
        GlassBox.tool_call(:catalog_note, title: "Paper Kites", note: "Public logline only."),
        cost: 0.003
      ) unless GlassBox.live?
      base = if GlassBox.provider_configured?(:gemini)
               GlassBox.chat(model: "gemini-3.7-flash", provider: :gemini)
             else
               puts "Gemini is not configured, so this run uses the default chat model."
               GlassBox.chat
             end
      chat = GlassBox.watch(base.with_tools(CatalogLookup, CatalogNote, defer: true))
      GlassBox.log "model", "#{chat.model.id} provider=#{chat.model.provider}"
      GlassBox.log "deferred tools", chat.deferred_tools.keys.inspect
      GlassBox.log "prompt", prompt(9)
      response = chat.ask prompt(9)
      question = chat.pending_questions.first
      if question&.approval?
        call = question.tool_call
        puts "APPROVAL NEEDED #{call.name} #{call.arguments.inspect}"
        if GlassBox.approved?("Approve the catalog note? Type yes: ")
          GlassBox.script_replies("The note was recorded.", cost: 0.003) unless GlassBox.live?
          question.approve
          puts "approved"
        else
          GlassBox.script_replies("The note was not recorded.", cost: 0.003) unless GlassBox.live?
          question.decline("Not approved in this run")
          puts "declined"
        end
        response = chat.complete
      end
      GlassBox.log "reply", response.content
      GlassBox.print_transcript(chat)
      true
    end

    def step_10
      card_schema
      company = company_named("Night Bazaar")
      card = { "company" => company.name, "composite" => company.composite, "band" => company.band }
      puts GlassBox::SBPI.explain(company.scores)
      GlassBox.script_replies(JSON.generate(card), cost: 0.002) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat.with_schema(BrandCardSchema))
      GlassBox.log "prompt", prompt(10)
      response = chat.ask prompt(10)
      GlassBox.log "response.parsed", response.parsed.inspect
      GlassBox.log "ruby card", card.inspect
      true
    end

    def step_11
      judgment = GlassBox.judge_ticket(PlaybackJudge, prompt(11), fixture_department: :technical)
      GlassBox.log "ticket", prompt(11)
      GlassBox.log "probability", judgment.urgent.probability
      GlassBox.log "choice", "#{judgment.department.choice} confidence=#{judgment.department.confidence}"
      company = company_named("Lantern Reel")
      puts "The judgment does not score the brand. #{company.name} is #{company.composite} (#{company.band}) from the local weighted sum."
      true
    end

    def step_12
      Object.send(:remove_const, :BrandScoreEvaluation) if Object.const_defined?(:BrandScoreEvaluation)
      klass = Class.new(RubyLLM::Evaluation) do
        dataset GlassBox::ROOT.join("guided/evals/brand_score.yml").to_s
        evaluator false

        def perform(input)
          GlassBox.catalog.find_company(input).band
        end

        def assertions
          assert_equal expected_output, output
        end
      end
      Object.const_set(:BrandScoreEvaluation, klass)
      report = BrandScoreEvaluation.run
      puts report
      path = ROOT.join("tmp/evaluations/BrandScoreEvaluation.json")
      FileUtils.mkdir_p(path.dirname)
      report.save(path)
      GlassBox.log "report", path.to_s
      raise "brand score evaluation failed" unless report.passed?

      true
    end

    def step_13
      enabled = GlassBox::Trace.enable_opentelemetry!
      GlassBox.log "OpenTelemetry.enable", enabled ? "subscribed" : "unavailable"
      company = company_named("Harbor and Thorn")
      GlassBox.log "prompt", prompt(13)
      response = nil
      GlassBox::Trace.record do |trace|
        RubyLLM.workflow("Score brand") do |workflow|
          workflow.step("Compute") do
            GlassBox.script_replies("#{company.name} has a composite of #{company.composite} in the #{company.band} band.", cost: 0.001) unless GlassBox.live?
            # The prompt carries the composite and the band that Ruby computed.
            response = GlassBox.chat.ask prompt(13)
          end
        end
        trace.print
      end
      GlassBox.log "reply", response.content
      puts GlassBox::SBPI.explain(company.scores)
      true
    end

    def step_14
      GlassBox.script_replies(
        GlassBox.tool_call(:publish_score, company: "Night Bazaar"),
        cost: 0.0042
      ) unless GlassBox.live?
      agent = nil
      RubyLLM.workflow("Publish score") do |workflow|
        agent = ScorePublisher.new
        GlassBox.watch(agent.chat)
        workflow.step("Ask") { agent.ask prompt(14) }
      end
      question = agent.pending_questions.first
      unless question&.approval?
        puts "This run did not pause on publish_score."
        return false if GlassBox.offline?

        GlassBox.print_transcript(agent.chat)
        return true
      end

      call = question.tool_call
      puts "APPROVAL NEEDED #{call.name} #{call.arguments.inspect}"
      puts "The tour called this agent.pending_approvals and agent.approve. This gem uses pending_questions and question.approve."
      unless GlassBox.approved?("Publish the Night Bazaar card? Type yes: ")
        GlassBox.script_replies("The card was not published.", cost: 0.0042) unless GlassBox.live?
        question.decline("Not approved in this run")
        agent.complete
        puts "Declined. Run this step again and type yes to save the checkpoint. bin/learn auto approves it."
        return false
      end

      GlassBox.script_replies("The card was published from the local scorer.", cost: 0.0042) unless GlassBox.live?
      question.approve
      response = agent.complete
      GlassBox.log "reply", response.content
      GlassBox.print_transcript(agent.chat)
      GlassBox.print_cost(agent)
      true
    end

    def step_15
      names = RubyLLM::Provider.providers.keys.sort
      GlassBox.log "providers in this gem", "#{names.size}: #{names.join(', ')}"
      puts "The tour card says 19 providers. This registry has #{names.size}."
      company = company_named("Copperframe")
      reply = "#{company.name} is #{company.composite}, #{company.band}."
      GlassBox.log "prompt", prompt(15)
      [[ "gpt-6.1-sol", :openai ], [ "claude-sonnet-5", :anthropic ], [ "gemini-3.7-flash", :gemini ]].each do |model, provider|
        unless GlassBox.provider_configured?(provider)
          puts "#{provider} is not configured. The constructor line is RubyLLM.chat(model: #{model.inspect}, provider: #{provider.inspect})."
          next
        end

        GlassBox.script_replies(reply, cost: 0.001) unless GlassBox.live?
        chat = GlassBox.chat(model: model, provider: provider)
        response = chat.ask prompt(15)
        puts "#{provider}: #{response.content}"
      end
      true
    end

    def step_16
      line = prompt(16)
      dir = ROOT.join("tmp/learn")
      FileUtils.mkdir_p(dir)
      speech = GlassBox.speak(line)
      # A provider returns mp3 by default, and the offline stand-in is a WAV file.
      path = dir.join("speech.#{speech.format}")
      speech.save(path.to_s)
      transcript = GlassBox.transcribe(path.to_s, expected_text: line)
      GlassBox.log "file", "#{path} (#{File.size(path)} bytes)"
      GlassBox.log "transcription.text", transcript.text
      puts "strings match: #{transcript.text == line}"
      true
    end

    def step_17
      scene = prompt(17)
      dir = ROOT.join("tmp/learn")
      FileUtils.mkdir_p(dir)
      GlassBox.log "prompt", scene
      image = GlassBox.paint(scene)
      image_path = dir.join("lantern.png")
      image.save(image_path.to_s)
      video = GlassBox.animate(scene)
      video_path = dir.join("lantern.mp4")
      video.save(video_path.to_s)
      GlassBox.log "image", "#{image_path} bytes=#{File.size(image_path)} model=#{image.model}"
      GlassBox.log "video", "#{video_path} bytes=#{File.size(video_path)} model=#{video.model}"
      true
    end

    def step_18
      titles = GlassBox.catalog.companies.map { |company| company.titles.first }
      # One call embeds all five blurbs, and #vectors holds one vector per blurb.
      embedding = GlassBox.embed(titles.map(&:blurb))
      titles.zip(embedding.vectors).each do |title, vector|
        puts "#{title.name}: vector length #{vector.length} model=#{embedding.model}"
      end
      puts
      query = prompt(18)
      rerank = GlassBox.rerank(query, GlassBox.catalog.help_articles)
      puts "rerank #{query.inspect} model=#{rerank.model}"
      rerank.results.first(3).each { |result| puts format("  %0.2f  %s", result.score, result.document) }
      true
    end

    def step_19
      document = GlassBox.ocr(ROOT.join("demos/fixtures/terms.pdf").to_s)
      GlassBox.log "ocr markdown", document.markdown.to_s.lines.first.to_s.strip
      comment = prompt(19)
      moderation = GlassBox.moderate(comment)
      GlassBox.log "comment", comment
      puts "flagged? #{moderation.flagged?}"
      true
    end

    def step_20
      puts "RubyLLM 2.1 published card, compared with 2.0. This step does not benchmark."
      puts "Stream 500 Anthropic text deltas          4.1 ms    2.4x faster"
      puts "Stream a 2 MB event in 16 KB pieces       2.0 ms    58x faster"
      puts "Memory kept by a streamed 40-turn chat    0.48 MB   58x less memory"
      puts "Eight threads loading the model registry  32 ms     8.5x faster"
      puts "Installed gem: ruby_llm #{RubyLLM::VERSION}"
      puts "The score for a company is a local sum, so it does not wait on a model."
      true
    end

    def step_21
      company = company_named("Harbor and Thorn")
      if GlassBox.offline?
        GlassBox.script_replies(
          RubyLLM::OverloadedError.new("overloaded"),
          "#{company.name} has a composite of #{company.composite} in the #{company.band} band.",
          cost: 0.0015
        )
      end
      # RubyLLM.chat raises a ConfigurationError for a provider with no key,
      # so the step checks for the Anthropic key before it builds the chat.
      if GlassBox.live? && !GlassBox.provider_configured?(:anthropic)
        puts "Anthropic is not configured, so this run builds no chat and sends no request."
        puts "Run this step with GLASS_BOX_MODE=offline to watch the fallback."
      else
        chat = GlassBox.watch(
          GlassBox.chat(model: "claude-sonnet-5", provider: :anthropic)
            .with_fallbacks("claude-haiku-4-5")
            .with_caching(ttl: "1h")
        )
        GlassBox.log "caching", chat.caching.inspect
        GlassBox.log "prompt", prompt(21)
        response = chat.ask prompt(21)
        GlassBox.log "reply", response.content
        GlassBox.log "response.model_id", response.model_id
        cache_read = response.tokens.cache_read
        GlassBox.log "cache_read", cache_read.nil? ? "none reported" : cache_read
      end
      true
    end

    def step_22
      GlassBox.script_replies("A micro-drama is a serial told in episodes of a minute or two, made for a phone screen.", cost: 0.002) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat.with_thinking(effort: :high).with_provider_tools(:web_search))
      GlassBox.log "thinking", chat.thinking.inspect
      GlassBox.log "provider tools", chat.provider_tools.inspect
      GlassBox.log "prompt", prompt(22)
      begin
        response = chat.ask prompt(22)
        GlassBox.log "reply", response.content
        GlassBox.print_citations(response)
      rescue RubyLLM::UnsupportedServerToolError, ArgumentError => error
        GlassBox.log "provider tool", "#{error.class}: #{error.message}"
      end
      puts "Recorded citation, not taken from this response:"
      puts GlassBox::Fixtures.recorded_citation.cited_text
      true
    end

    def step_23
      company = company_named("Kite Alley")
      puts GlassBox::SBPI.explain(company.scores)
      facts = ROOT.join("demos/fixtures/notes.txt")
      GlassBox.script_replies("The note names The Last Lantern, 48 episodes, on Lantern.", cost: 0.0042) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat.with_citations)
      GlassBox.log "prompt", "#{prompt(23)} (with #{facts.basename})"
      response = chat.ask prompt(23), with: facts.to_s
      GlassBox.log "reply", response.content
      GlassBox.print_citations(response)
      if response.citations.empty?
        puts "No citations on this response. A provider returns them on response.citations when it has them."
      end
      GlassBox.print_cost(chat)
      true
    end

    def step_24
      articles = GlassBox.catalog.help_articles.first(3)
      chats = articles.map do |article|
        chat = GlassBox.chat.with_instructions(prompt(24, 1))
        chat.ask_later("#{prompt(24, 0)} #{article}")
      end
      chats.each_with_index do |chat, index|
        puts "staged #{index + 1}: #{chat.messages.last.content}"
      end
      if GlassBox.submit_batches?
        batch = RubyLLM.batch(chats)
        GlassBox.log "batch", "#{batch.id} #{batch.status.inspect}"
      else
        puts "RubyLLM.batch was not called. GLASS_BOX_MODE=live and GLASS_BOX_BATCH=1 submit the batch."
      end
      true
    end

    def step_25
      found = GlassBox.catalog.find_title("Room 4B")
      GlassBox.script_replies(
        GlassBox.tool_call(:catalog_lookup, name: "Room 4B"),
        "#{found.last.name} has #{found.last.episodes} episodes.",
        cost: 0.002
      ) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat.with_tools(CatalogLookup).with_compaction(at: 50_000))
      GlassBox.log "compaction", chat.compaction.inspect
      GlassBox.log "prompt", prompt(25)
      chat.ask_later prompt(25)
      steps = 0
      until chat.complete? || chat.waiting? || steps > 6
        steps += 1
        message = chat.step
        state = chat.waiting? ? "waiting" : (chat.complete? ? "complete" : "running")
        puts "step #{steps} state=#{state} role=#{message&.role} content=#{message&.content.to_s[0, 80].inspect}"
      end
      true
    end

    def step_26
      %w[claude-sonnet-5 gemini-3.8-flash].each do |id|
        model = RubyLLM.models.find(id)
        puts "#{model.id} provider=#{model.provider} vision=#{model.supports?('vision')} structured_output=#{model.supports?('structured_output')}"
      end
      sentence = prompt(26)
      if GlassBox.live?
        count = GlassBox.chat.count_tokens(sentence)
        GlassBox.log "count_tokens", count
      else
        puts "chat.count_tokens was not called. The tour card shows 5 tokens for #{sentence.inspect}."
        puts "This process did not compute that number."
      end
      true
    end

    def step_27
      puts "gem install ruby_llm"
      puts "bundle add ruby_llm --version #{RubyLLM::VERSION}"
      puts "https://rubyllm.com/"
      puts "https://github.com/crmne/ruby_llm/releases/download/v2.1.0/rubyllm-tour.mp4"
      puts "Catalog rows: #{GlassBox.catalog.companies.map(&:name).join(', ')}"
      puts "Category examples, not scored: #{GlassBox.catalog.category_examples.join(', ')}"
      puts "The tour's last card has no code on it. This step closes the course."
      true
    end

    # The teaching part of a lesson file: everything between the title and the
    # Run section.
    def lesson_body(step)
      text = LESSONS.join("#{step[:slug]}.md").read
      text.split(/^## Run$/).first.sub(/\A# .*\n/, "").strip
    end

    def lesson_for_terminal(step)
      lesson_body(step).split(/\n{2,}/).map do |block|
        block.start_with?("## ") ? block.delete_prefix("## ").upcase : wrap(block)
      end.join("\n\n")
    end

    def wrap(paragraph)
      lines = [+""]
      paragraph.split.each do |word|
        lines << +"" if !lines.last.empty? && lines.last.length + 1 + word.length > WRAP
        lines.last << " " unless lines.last.empty?
        lines.last << word
      end
      lines.join("\n")
    end

    def wait_for_enter(step)
      return unless $stdin.tty? && $stdout.tty?

      print "Press Enter to run step #{step[:n]}. "
      $stdin.gets
      puts
    end

    # The fixed text of each prompt a step sends. The lesson for the step quotes
    # every string here, and test/glass_box/lessons_test.rb checks that it does.
    def prompts
      @prompts ||= build_prompts
    end

    def prompt(number, index = 0)
      prompts.fetch(number).fetch(index)
    end

    def build_prompts
      lantern = company_named("Lantern Reel")
      bazaar = company_named("Night Bazaar")
      harbor = company_named("Harbor and Thorn")
      copper = company_named("Copperframe")
      power = GlassBox::SBPI.dimension("distribution_power")
      {
        1 => ["The catalog lists The Last Lantern under the company #{lantern.name}. Which company publishes The Last Lantern?"],
        2 => ["In one sentence, summarize this fictional series:"],
        3 => ["In one sentence, summarize this fictional series:", "Compare it with this one:"],
        4 => ["#{power[:label]} has a weight of #{power[:weight]}, the largest of the five weights. Write one sentence that says so."],
        5 => ["#{lantern.name} has a composite of #{lantern.composite} in the #{lantern.band} band. Say so in one sentence."],
        6 => ["List only the title and the episode count you can read in this note."],
        7 => ["How many episodes does Salt Wedding have, and who publishes it?"],
        9 => ["Add a public note on Paper Kites."],
        10 => ["Return a score card for #{bazaar.name}. Its composite is #{bazaar.composite} and its band is #{bazaar.band}."],
        11 => ["Night Bazaar playback failed on episode 12 of Stall Seven."],
        13 => ["#{harbor.name} has a composite of #{harbor.composite} in the #{harbor.band} band. Say so in one sentence."],
        14 => ["Publish the Night Bazaar score card."],
        15 => ["#{copper.name} has a composite of #{copper.composite} in the #{copper.band} band. Say so in one sentence."],
        16 => ["#{bazaar.name} composite is #{bazaar.composite}, #{bazaar.band}."],
        17 => ["A paper lantern over a night market, flat illustration, no text"],
        18 => ["How do I reset my password?"],
        19 => ["The ending of Stall Seven was fair."],
        21 => ["#{harbor.name} has a composite of #{harbor.composite} in the #{harbor.band} band. Say so in one sentence."],
        22 => ["In one sentence, what is a micro-drama?"],
        23 => ["What does the note say?"],
        24 => ["Classify this help line:", "Answer with one word: account, billing, or playback."],
        25 => ["How many episodes does Room 4B have?"],
        26 => ["Ruby is elegant and expressive"]
      }.freeze
    end

    def company_named(name)
      GlassBox.catalog.find_company(name) or raise "missing catalog company #{name}"
    end

    def ask(question, reply)
      GlassBox.script_replies(reply, cost: 0.0042) unless GlassBox.live?
      chat = GlassBox.watch(GlassBox.chat)
      GlassBox.log "prompt", question
      response = chat.ask(question)
      GlassBox.log "reply", response.content
      GlassBox.print_cost(chat)
      response
    end

    def card_schema
      return if defined?(BrandCardSchema)

      Object.const_set(:BrandCardSchema, Class.new(Schematist::Schema) do
        string :company
        number :composite
        string :band
      end)
    end

    def progress
      return { "completed" => [] } unless PROGRESS.file?

      JSON.parse(PROGRESS.read)
    end

    def mark!(number)
      data = progress
      data["completed"] = (Array(data["completed"]) + [number]).uniq.sort
      FileUtils.mkdir_p(PROGRESS.dirname)
      PROGRESS.write(JSON.pretty_generate(data))
    end

    class PlaybackJudge < RubyLLM::Judge
      probability :urgent, "Is the ticket urgent?"
      choice :department, "Which desk should take it?" do
        billing "Payments and refunds"
        technical "Bugs and playback"
        other "Everything else"
      end
    end
  end
end
