#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "16  Speech and transcription"

line = "Welcome to the show!"
dir = GlassBox.output_dir("16-speech-transcription")
path = dir.join("speech.wav")
speech = GlassBox.speak(line)
speech.save(path.to_s)
transcript = GlassBox.transcribe(path.to_s, expected_text: line)
GlassBox.log "source", line
GlassBox.log "file", "#{path} (#{File.size(path)} bytes, #{speech.mime_type})"
GlassBox.log "transcription.text", transcript.text
puts "round trip strings match: #{transcript.text == line}"
puts
