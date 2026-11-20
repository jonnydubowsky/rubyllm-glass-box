#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "12  Evaluating an agent against a dataset"

# The tour's perform method calls SupportAgent.new.ask(input), and the tour
# leaves the evaluator unset, so RubyLLM asks the chat model whether each
# answer matches expected_output. This demo answers from a lookup table and
# sets evaluator false, so a Ruby assertion grades each case. The failing case
# then fails the same way on every run, with no network.
module CannedSupportAgent
  def self.answer(input)
    text = input.to_s.downcase
    if text.include?("unopened")
      "Yes, unopened items can be returned within 30 days."
    elsif text.include?("damaged")
      "Yes, damaged items can be returned within 30 days."
    else
      # Wrong on purpose. The dataset says sale items are final.
      "Yes, sale items can be returned within 30 days."
    end
  end
end

class SupportEvaluation < RubyLLM::Evaluation
  dataset File.expand_path("support_evaluation.yml", __dir__)
  evaluator false

  def perform(input)
    CannedSupportAgent.answer(input)
  end

  def assertions
    assert_equal expected_output, output
  end
end

report = SupportEvaluation.run
puts report
path = GlassBox::ROOT.join("tmp/evaluations/SupportEvaluation.json")
FileUtils.mkdir_p(path.dirname)
report.save(path)
puts
puts "Report: #{path}"
puts "passed? #{report.passed?}"
puts "This script exits 0 even though one case failed, so bin/demo all can continue."
puts
