#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "14  An agent, a tool that needs approval, and a workflow"

# The tour calls agent.pending_approvals and agent.approve(...).
# ruby_llm 2.2.3 uses pending_questions and question.approve.
# chat.approve(tool_call) still exists and records the same decision.

class IssueRefund < RubyLLM::Tool
  description "Issues a refund for an order"
  requires_approval

  def execute(order_id:)
    { refunded: true, order_id: order_id }
  end
end

class SupportAgent < RubyLLM::Agent
  # The tour's agent names claude-sonnet-5. Without an Anthropic key, a live
  # run uses the default chat model.
  agent_model, agent_provider = GlassBox.model_for("claude-sonnet-5", :anthropic)
  model agent_model, provider: agent_provider
  instructions "Resolve billing tickets. Call the refund tool when the customer asks for a refund."
  tools IssueRefund
end

GlassBox.script_replies(
  GlassBox.tool_call(:issue_refund, order_id: 42),
  cost: 0.0042
)

answer = nil
agent = nil
RubyLLM.workflow("Billing ticket") do |workflow|
  agent = SupportAgent.new
  GlassBox.watch(agent.chat)
  workflow.step("Resolve") { agent.ask "Refund order 42" }
  question = agent.pending_questions.first
  raise "expected an approval question" unless question&.approval?

  call = question.tool_call
  puts "APPROVAL NEEDED"
  puts "SupportAgent wants to run"
  puts "#{call.name} #{call.arguments.inspect}"
  puts "[Deny] [Approve]"
  if GlassBox.approved?
    GlassBox.script_replies "Refund issued for order 42.", cost: 0.0042
    question.approve
    puts "approved with question.approve"
  else
    GlassBox.script_replies "The refund was not issued.", cost: 0.0042
    question.decline("Not approved in this run")
    puts "declined with question.decline"
    puts
  end
  answer = workflow.step("Continue") { agent.complete }
end
GlassBox.log "reply", answer.content
GlassBox.print_transcript(agent.chat)
GlassBox.print_cost(agent)
