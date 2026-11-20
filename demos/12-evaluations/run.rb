#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "12  Evaluating an agent against a dataset"

# The tour leaves the evaluator unset, so RubyLLM asks the chat model whether
# the answer matches expected_output. This demo sets evaluator false and checks
# the answer with a Ruby assertion. That keeps the failing case deterministic
# and offline. The report still names the case.
module FaqAgent
  def self.answer(input)
    text = input.to_s.downcase
    if text.include?("unopened")
      "Yes, unopened items can be returned within 30 days."
    elsif text.include?("episode") || text.include?("cliffhanger")
      "Reload the player and check the connection, then resume the episode."
    else
      "Yes, sale items can be returned within 30 days."
    end
  end
end

class FaqEvaluation < RubyLLM::Evaluation
  dataset File.expand_path("faq_evaluation.yml", __dir__)
  evaluator false

  def perform(input)
    FaqAgent.answer(input)
  end

  def assertions
    assert_includes output.downcase, expected_output
  end
end

report = FaqEvaluation.run
puts report
path = GlassBox::ROOT.join("tmp/evaluations/FaqEvaluation.json")
FileUtils.mkdir_p(path.dirname)
report.save(path)
puts "Report: #{path}"
puts "passed? #{report.passed?}"
