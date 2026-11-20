# frozen_string_literal: true

require_relative "../test_helper"

class SupportTest < Minitest::Test
  def test_the_trace_prints_events_in_start_order_with_nesting
    trace = GlassBox::Trace.new
    trace.instrument("workflow.ruby_llm", { workflow_name: "Answer question" }) do
      trace.instrument("workflow_step.ruby_llm", { workflow_name: "Answer question", workflow_step_name: "Generate answer" }) do
        trace.instrument("chat.ruby_llm", { model: "a-model" }) { nil }
        trace.instrument("tool_call.ruby_llm", { tool_name: "lookup_order" }) { nil }
      end
    end
    rows = trace.events.map { |event| [event[:depth], event[:name], event[:detail]] }
    assert_equal [
      [0, "workflow.ruby_llm", "Answer question"],
      [1, "workflow_step.ruby_llm", "Generate answer"],
      [2, "chat.ruby_llm", "a-model"],
      [2, "tool_call.ruby_llm", "lookup_order"]
    ], rows
  end

  def test_a_provider_error_report_hides_the_key
    error = RubyLLM::UnauthorizedError.new("Incorrect API key provided: sk-proj-abc123************************wxyz.")
    report = GlassBox.provider_error_report(error)
    refute_includes report, "sk-proj"
    refute_includes report, "wxyz"
    assert_includes report, "[key hidden]"
    assert_includes report, "GLASS_BOX_MODE=offline"
  end

  def test_model_for_keeps_the_wanted_model_when_the_provider_is_configured
    # The suite runs offline, and offline every provider counts as configured.
    assert_equal ["claude-sonnet-5", :anthropic], GlassBox.model_for("claude-sonnet-5", :anthropic)
  end

  def test_script_replies_passes_the_interval_to_the_stub
    GlassBox.script_replies("one two", cost: 0.001, interval: 0.01)
    _reply, options = RubyLLM::TestHelper::Script.next_reply
    assert_equal({ cost: 0.001, interval: 0.01 }, options)
  ensure
    GlassBox.arm_offline_stub!
  end
end
