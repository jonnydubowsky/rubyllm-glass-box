#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "23  Citations and cost"

facts = GlassBox::ROOT.join("demos/fixtures/notes.txt")
GlassBox.script_replies "The Last Lantern is a Lantern original with 48 episodes.", cost: 0.0042
chat = GlassBox.watch(GlassBox.chat.with_citations)
response = chat.ask "Who is the series about? Quote the note.", with: facts.to_s
GlassBox.log "reply", response.content
GlassBox.print_citations(response)
if response.citations.empty?
  puts "Document citations arrive on response.citations when the provider returns them."
  puts "Recorded card, not from this response:"
  puts GlassBox::Fixtures.recorded_citation.cited_text
  puts
end
GlassBox.print_cost(chat)
