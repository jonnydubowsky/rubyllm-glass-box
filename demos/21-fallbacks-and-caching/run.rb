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

# RubyLLM.chat raises a ConfigurationError for a provider with no key, so the
# demo checks for the Anthropic key before it builds the chat.
if GlassBox.live? && !GlassBox.provider_configured?(:anthropic)
  puts "Anthropic is not configured, so this run builds no chat and sends no request."
  puts "The tour's calls are with_fallbacks(\"claude-haiku-4-5\") and with_caching(ttl: \"1h\")."
  puts "Run with GLASS_BOX_MODE=offline to watch the fallback."
  puts
else
  chat = GlassBox.watch(
    GlassBox.chat(model: "claude-sonnet-5", provider: :anthropic)
      .with_fallbacks("claude-haiku-4-5")
      .with_caching(ttl: "1h")
  )
  GlassBox.log "caching config", chat.caching.inspect
  prompt = "In one sentence, what is a model fallback?"
  GlassBox.log "prompt", prompt
  response = chat.ask prompt
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
