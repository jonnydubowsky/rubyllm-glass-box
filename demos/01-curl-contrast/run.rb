#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "01  A raw provider request next to RubyLLM"

curl = <<~CURL
  curl https://api.openai.com/v1/responses \\
    -H "Content-Type: application/json" \\
    -H "Authorization: Bearer $OPENAI_API_KEY" \\
    -d '{
      "model": "gpt-5.6",
      "input": "Write a one-sentence bedtime story about a unicorn."
    }'
CURL
GlassBox.log "curl (not sent)", curl

body = JSON.parse(File.read(GlassBox::ROOT.join("demos/fixtures/openai_response.json")))
message = body.fetch("output").find { |item| item["type"] == "message" && item["role"] == "assistant" }
text = message.fetch("content").find { |part| part["type"] == "output_text" }.fetch("text")
GlassBox.log "assistant text from the fixture body", text
puts "The text is nested. Find the output item whose type is message. Do not read output[0]."
puts

prompt = "Write a one-sentence bedtime story about a unicorn."
GlassBox.script_replies text, cost: 0.0042 unless GlassBox.live?
chat = GlassBox.watch(GlassBox.chat)
GlassBox.log "prompt", prompt
response = chat.ask prompt
GlassBox.log "RubyLLM reply", response.content
GlassBox.print_cost(chat)
