#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "03  The same chat remembers the last turn"

first = "Under a sky full of stars, a small unicorn learned that kindness shines brighter than any horn."
second = "A small dragon found a lost star and carried it home before dawn."
GlassBox.script_replies first, second, cost: 0.0042
chat = GlassBox.watch(GlassBox.chat)
chat.ask "Write a one-sentence bedtime story about a unicorn."
chat.ask "Tell me another."
GlassBox.print_transcript(chat)
puts "roles: #{chat.messages.map(&:role).inspect}"
GlassBox.print_cost(chat)
