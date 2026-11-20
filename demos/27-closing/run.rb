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
puts "This directory is the course's closing script. The tour card has no demo of its own."
puts "Installed: ruby_llm #{RubyLLM::VERSION}"
puts
