#!/usr/bin/env ruby
# frozen_string_literal: true

require "marcel"
require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "06  Attachments: a path, a URL, and mixed files"

root = GlassBox::ROOT.join("demos/fixtures")
files = [root.join("pixel.png"), root.join("terms.pdf"), root.join("notes.txt"), root.join("clip.mp4")]
files.each do |path|
  type = Marcel::MimeType.for(Pathname.new(path), name: path.basename.to_s)
  puts "#{path.basename}  #{type}  #{path.size} bytes"
end
puts
puts "Tour form, not fetched: with: \"https://example.com/eiffel_tower.jpg\""
puts

GlassBox.script_replies "A 1 pixel PNG, a one-page PDF titled Service Agreement, and a note for The Last Lantern.", cost: 0.003
chat = GlassBox.watch(GlassBox.chat)
prompt = "List the file names and media types you were given. Do not invent a score."
response = chat.ask(prompt, with: files.map(&:to_s))
GlassBox.log "prompt", prompt
GlassBox.log "reply", response.content
attached = chat.messages.first.attachments
if attached
  Array(attached).each do |attachment|
    name = attachment.respond_to?(:filename) ? attachment.filename : attachment.inspect
    mime = attachment.respond_to?(:mime_type) ? attachment.mime_type : nil
    puts "attachment #{name} #{mime}"
  end
end
puts
GlassBox.print_cost(chat)
