#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "26  The model registry and token counting"

%w[claude-sonnet-5 gemini-3.8-flash].each do |id|
  model = RubyLLM.models.find(id)
  puts "#{model.id}  provider=#{model.provider}"
  puts "  capabilities: #{model.capabilities.join(", ")}"
  %w[vision reasoning citations video caching function_calling structured_output].each do |name|
    puts "  supports #{name}: #{model.supports?(name)}"
  end
  puts
end

text = "Ruby is elegant and expressive"
chat = GlassBox.chat
puts "sentence: #{text}"
if GlassBox.live?
  count = chat.count_tokens(text)
  GlassBox.log "count_tokens", count
else
  puts "chat.count_tokens was not called. It asks the provider for a count."
  puts "The tour card shows 5 tokens for this sentence. This process did not compute that number."
  puts "A missing count is not zero."
end
puts
