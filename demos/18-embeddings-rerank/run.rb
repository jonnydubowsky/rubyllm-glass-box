#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "18  Embeddings and reranking"

text = "Ruby is elegant and expressive"
embedding = GlassBox.embed(text)
vectors = embedding.vectors
GlassBox.log "vectors", "#{vectors.first(8).inspect} length=#{vectors.length} model=#{embedding.model}"
puts "A single string also answers #vector. An array of strings keeps one vector per string on #vectors."
puts

documents = [
  "Reset your password in Settings.",
  "Use Forgot password to get a reset link.",
  "Two-factor codes expire after 30 seconds.",
  "Invoices arrive by email.",
  "Our office is closed on Sundays."
]
query = "How do I reset my password?"
rerank = GlassBox.rerank(query, documents)
puts "query: #{query}"
puts "model: #{rerank.model}"
rerank.results.each_with_index do |result, index|
  puts format("%d  %-52s %0.2f", index + 1, result.document, result.score)
end
puts
