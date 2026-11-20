#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "07  A Ruby tool the model can call"

module Forecast
  def self.current(latitude, longitude)
    { temperature: 18, wind: 12, latitude: latitude, longitude: longitude }
  end
end

class Weather < RubyLLM::Tool
  description "Get current weather for a location"

  def execute(latitude:, longitude:)
    Forecast.current(latitude, longitude)
  end
end

GlassBox.script_replies(
  GlassBox.tool_call(:weather, latitude: 52.52, longitude: 13.41),
  "It's 18°C and breezy in Berlin.",
  cost: 0.002
)
chat = GlassBox.watch(GlassBox.chat.with_tools(Weather))
response = chat.ask "What's the weather in Berlin?"
GlassBox.log "reply", response.content
GlassBox.print_transcript(chat)
GlassBox.print_cost(chat)
