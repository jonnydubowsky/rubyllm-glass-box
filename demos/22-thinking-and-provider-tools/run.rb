#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "22  Extended thinking and provider web search"

GlassBox.script_replies "The newest Ruby is out with faster YJIT.", cost: 0.003
chat = GlassBox.watch(
  GlassBox.chat
    .with_thinking(effort: :high)
    .with_provider_tools(:web_search)
)
GlassBox.log "thinking", chat.thinking.inspect
GlassBox.log "provider tools", chat.provider_tools.inspect
begin
  response = chat.ask "What is the latest Ruby release?"
  GlassBox.log "reply", response.content
  thinking = response.respond_to?(:thinking) ? response.thinking : nil
  GlassBox.log "response.thinking", thinking&.respond_to?(:text) ? thinking.text.inspect : thinking.inspect
  GlassBox.print_citations(response)
rescue RubyLLM::UnsupportedServerToolError, RubyLLM::ArgumentError, RubyLLM::Error => error
  GlassBox.log "provider tools not sent", "#{error.class}: #{error.message}"
  puts "The chat was still configured with with_thinking(effort: :high) and with_provider_tools(:web_search)."
end
puts "Recorded card from the tour, separate from this run's citations:"
card = GlassBox::Fixtures.recorded_citation
puts card.cited_text
puts
