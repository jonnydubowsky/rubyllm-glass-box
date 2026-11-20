#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "13  Tracing a run with OpenTelemetry"

enabled = GlassBox::Trace.enable_opentelemetry!
GlassBox.log "RubyLLM::OpenTelemetry.enable", enabled ? "subscribed" : "unavailable"

class LookupOrder < RubyLLM::Tool
  description "Look up a fictional order"

  def execute(order_id:)
    { order_id: order_id, status: "packed", path: "GET /orders/#{order_id}" }
  end
end

GlassBox.script_replies(
  GlassBox.tool_call(:lookup_order, order_id: 42),
  "Order 42 is packed.",
  cost: 0.002
)

GlassBox::Trace.record do |trace|
  RubyLLM.workflow("Answer question") do |workflow|
    workflow.step("Generate answer") do
      chat = GlassBox.watch(GlassBox.chat.with_tools(LookupOrder))
      chat.ask "Where is order 42?"
    end
  end
  trace.print
end
