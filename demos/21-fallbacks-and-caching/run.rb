#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "21  Model fallbacks and prompt caching"

if GlassBox.offline?
  GlassBox.script_replies(
    RubyLLM::OverloadedError.new("overloaded"),
    "The backup model answered the catalog question.",
    cost: 0.0015
  )
end

chat = GlassBox.watch(
  GlassBox.chat(model: "claude-sonnet-5", provider: :anthropic)
    .with_fallbacks("claude-haiku-4-5")
    .with_caching(ttl: "1h")
)
GlassBox.log "caching config", chat.caching.inspect
if GlassBox.live? && !GlassBox.provider_configured?(:anthropic)
  puts "Anthropic is not configured, so this run does not send the fallback request."
  puts "with_fallbacks(\"claude-haiku-4-5\") and with_caching(ttl: \"1h\") are set on the chat object."
else
  response = chat.ask "In one sentence, what is a model fallback?"
  GlassBox.log "response model", response.model_id
  GlassBox.log "reply", response.content
  cache_read = response.tokens.cache_read
  if cache_read
    GlassBox.log "cache", "cache_read=#{cache_read}"
  else
    GlassBox.log "cache", "no cache_read was reported. A missing cache read is not a hit, and it is not zero."
  end
  GlassBox.print_cost(chat)
end
