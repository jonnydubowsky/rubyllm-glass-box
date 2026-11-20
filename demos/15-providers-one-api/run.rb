#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "15  One Ruby API, many providers"

puts "RubyLLM.chat(model: \"claude-opus-5-5\")"
puts "RubyLLM.chat(model: \"gemini-3.8-flash\")"
puts "RubyLLM.chat(model: \"claude-sonnet-5\", provider: :bedrock)"
puts
slugs = RubyLLM::Provider.providers.keys.map(&:to_s).sort
GlassBox.log "providers in ruby_llm #{RubyLLM::VERSION}", "#{slugs.size}: #{slugs.join(", ")}"
puts "The tour card says 19 providers. This gem registers #{slugs.size}."
puts "The homepage for 2.2.3 says 23. The extra slugs against that tour list are meta, minimax, moonshot, and zai."
puts

calls = [
  ["claude-opus-5-5", :anthropic],
  ["gemini-3.8-flash", :gemini],
  ["claude-sonnet-5", :bedrock]
]
replies = calls.map { |model, provider| "#{model} via #{provider} answers in one Ruby call." }
GlassBox.script_replies(*replies, cost: 0.001) if GlassBox.offline?

calls.each do |model, provider|
  if GlassBox.live? && !GlassBox.provider_configured?(provider)
    puts "skipped ask for #{model} on #{provider}: that provider is not configured"
    next
  end

  chat = GlassBox.chat(model: model, provider: provider)
  response = chat.ask "In one sentence, what is a provider argument on RubyLLM.chat?"
  puts "#{chat.model.id} provider=#{chat.model.provider}"
  puts response.content
  puts
end
