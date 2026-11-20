#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

# This file does not boot Rails. ruby_llm 2.2.3's chat UI generator writes
# ChatResponseJob, which calls chat.complete(&:broadcast). Chunk#broadcast
# appends through Message#broadcast_chunk. The tour showed ChatStreamJob and
# message.broadcast_append_chunk, which generator releases 1.14 through 2.1
# wrote into the app's message model. Both shapes are printed below. The runnable
# stand-in keeps an in-memory chat and prints each chunk the way the page would.

GlassBox.boot!
GlassBox.banner "05  Streaming a chat through a Rails job"

puts <<~JOB
  # Tour, app/jobs/chat_stream_job.rb
  class ChatStreamJob < ApplicationJob
    def perform(chat_id)
      chat = Chat.find(chat_id)
      chat.complete do |chunk|
        message = chat.messages.last
        message.broadcast_append_chunk(chunk.content)
      end
    end
  end

  # ruby_llm 2.2.3 generator, app/jobs/chat_response_job.rb
  class ChatResponseJob < ApplicationJob
    def perform(chat_id)
      chat = Chat.find(chat_id)
      chat.complete(&:broadcast)
    end
  end

JOB

InMemoryMessage = Struct.new(:chunks) do
  def broadcast_chunk(chunk)
    return if chunk.content.to_s.empty?

    chunks << chunk.content
    puts "broadcast_chunk #{chunk.content.inspect}"
  end

  def content
    chunks.join
  end
end

GlassBox.script_replies "Content Strength is library depth and production quality, weighted at 20 percent.", cost: 0.002, interval: 0.04
chat = GlassBox.watch(GlassBox.chat)
page = InMemoryMessage.new([])
prompt = "Content Strength is library depth and production quality, weighted at 20 percent. Say so in one sentence."
GlassBox.log "prompt", prompt
chat.ask(prompt) do |chunk|
  page.broadcast_chunk(chunk)
end
puts
GlassBox.log "page text", page.content
GlassBox.print_cost(chat)
