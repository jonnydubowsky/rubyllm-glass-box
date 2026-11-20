#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "11  Typed judgments"

class TicketTriage < RubyLLM::Judge
  probability :urgent, "Does this need attention today?"
  choice :department, "Which team should handle this?" do
    billing "Payments and refunds"
    technical "Bugs and integrations"
    other "Everything else"
  end
end

# The tour also shows a local model:
#   class TicketTriage < RubyLLM::Judge
#     model "clef-flash", provider: :ollama
#   end
# clef-flash is not in the bundled registry until Ollama is running and the
# registry is refreshed. This demo does not claim that model is installed.

text = "Please refund the duplicate charge today."
judgment = GlassBox.judge_ticket(TicketTriage, text)
GlassBox.log "input", text
puts "urgent.probability  #{judgment.urgent.probability}"
puts "department.choice   #{judgment.department.choice}"
puts "model               #{judgment.model}"
cost = judgment.cost.total
puts(cost.nil? ? "cost                nil (a missing cost is not zero)" : format("cost                $%.4f", cost))
puts
