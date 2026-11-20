#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "19  OCR and moderation"

pdf = GlassBox::ROOT.join("demos/fixtures/terms.pdf")
document = GlassBox.ocr(pdf.to_s)
GlassBox.log "markdown", document.markdown
sample = "Some user-generated content"
moderation = GlassBox.moderate(sample)
GlassBox.log "input", sample
puts "flagged? #{moderation.flagged?}"
cost = moderation.cost.total
puts(cost.nil? ? "cost: nil (a missing cost is not zero)" : format("cost: $%.4f", cost))
puts
