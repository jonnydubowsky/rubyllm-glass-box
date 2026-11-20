#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "04  Streaming tokens with a block"

haiku = "Blocks yield like spring rain, methods bloom in quiet red, joy compiles itself."
GlassBox.script_replies haiku, cost: 0.0011, interval: 0.04
chat = GlassBox.watch(GlassBox.chat)
print "chunks: "
chat.ask("Write a haiku about Ruby.") { |chunk| print chunk.content }
puts
puts
GlassBox.print_cost(chat)
