#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "24  Batches of chats"

questions = [
  "Classify: Can I return an unopened item after 14 days?",
  "Classify: The episode stops at the cliffhanger.",
  "Classify: Can I return a sale pass?"
]
chats = questions.map do |question|
  chat = GlassBox.chat.with_instructions("Answer with one of: returns, playback, billing.")
  chat.ask_later(question)
end
chats.each_with_index do |chat, index|
  puts "chat #{index + 1} staged role=#{chat.messages.last.role} content=#{chat.messages.last.content.inspect}"
end
puts
puts "Tool approval on a single chat is chat.approve(tool_call), or question.approve."
puts "See demos/14-agents-approval-workflows."
puts
if GlassBox.submit_batches?
  batch = RubyLLM.batch(chats)
  GlassBox.log "batch.id", batch.id
  GlassBox.log "batch.status", batch.status.inspect
else
  puts "RubyLLM.batch(chats) was not called."
  puts "Set GLASS_BOX_MODE=live and GLASS_BOX_BATCH=1 to submit. A batch id comes back from the provider, and the results arrive later."
end
puts
