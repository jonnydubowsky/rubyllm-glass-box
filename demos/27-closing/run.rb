#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "27  Use Ruby"

puts <<~CARD
  You don't need Python or JavaScript for AI.
  Use Ruby.

  RubyLLM
  The Ruby-native AI framework.
  bundle add ruby_llm --version #{RubyLLM::VERSION}
  https://rubyllm.com/
  Tour: https://github.com/crmne/ruby_llm/releases/download/v2.1.0/rubyllm-tour.mp4
CARD
puts "The tour's closing card has no code on it. This script prints the card and the pinned version."
puts "Installed: ruby_llm #{RubyLLM::VERSION}"
puts
