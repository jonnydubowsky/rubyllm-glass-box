#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "02  chat.ask starts a conversation"

prompt = "Write a one-sentence bedtime story about a unicorn."
reply = "Under a sky full of stars, a small unicorn learned that kindness shines brighter than any horn."
GlassBox.script_replies reply, cost: 0.0042
chat = GlassBox.watch(GlassBox.chat)
GlassBox.log "prompt", prompt
response = chat.ask prompt
GlassBox.log "reply", response.content
GlassBox.print_transcript(chat)
GlassBox.print_cost(chat)
