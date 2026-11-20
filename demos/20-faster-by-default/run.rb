#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "20  Faster by default in RubyLLM 2.1"

puts <<~CARD
  Faster by default.
  RubyLLM 2.1
  Stream 500 Anthropic text deltas          4.1 ms    2.4x faster
  Stream a 2 MB event in 16 KB pieces       2.0 ms    58x faster
  Memory kept by a streamed 40-turn chat    0.48 MB   58x less memory
  Eight threads loading the model registry  32 ms     8.5x faster
  Compared to RubyLLM 2.0. Same code, less work on every call.
CARD
puts "Installed gem: ruby_llm #{RubyLLM::VERSION}"
puts "Source: https://rubyllm.com/whats-new-in-2-1/"
puts "This demo reads the published card. It does not run a benchmark."
puts
