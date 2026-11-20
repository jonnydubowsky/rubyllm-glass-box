#!/usr/bin/env ruby
# frozen_string_literal: true

require "marcel"
require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "06  Attachments: a path, a URL, and mixed files"

root = GlassBox::ROOT.join("demos/fixtures")
image = root.join("pixel.png")
pdf = root.join("terms.pdf")
note = root.join("notes.txt")
clip = root.join("clip.mp4")

puts "MIME types from Marcel:"
[image, pdf, note, clip].each do |path|
  type = Marcel::MimeType.for(path, name: path.basename.to_s)
  puts "  #{path.basename}  #{type}  #{path.size} bytes"
end
puts

def print_attachments(message)
  Array(message.attachments).each do |attachment|
    puts "attachment #{attachment.filename} #{attachment.mime_type}"
  end
  puts
end

# Form 1 on the tour's card: one local path.
GlassBox.script_replies "A PNG image that is one pixel wide and one pixel tall.", cost: 0.001
chat = GlassBox.watch(GlassBox.chat)
prompt = "What's in this image?"
GlassBox.log "prompt, with one path", prompt
response = chat.ask(prompt, with: image.to_s)
GlassBox.log "reply", response.content
print_attachments(chat.messages.first)

# Form 2: a URL. The call is valid, and this demo does not fetch anything.
puts "URL form from the tour, not sent:"
puts "  chat.ask \"What's in this image?\", with: \"https://example.com/eiffel_tower.jpg\""
puts

# Form 3: an array that mixes file types. clip.mp4 is a 20-byte stub that no
# provider can decode, so the demo attaches it only when the stub answers.
files = [image, pdf, note]
files << clip if GlassBox.offline?
GlassBox.script_replies "A 1 pixel PNG, a one-page PDF titled Service Agreement, a note for The Last Lantern, and a video file.", cost: 0.003
mixed = GlassBox.watch(GlassBox.chat)
prompt = "What's in these files?"
GlassBox.log "prompt, with #{files.size} files", prompt
response = mixed.ask(prompt, with: files.map(&:to_s))
GlassBox.log "reply", response.content
print_attachments(mixed.messages.first)
puts "In live mode this demo leaves clip.mp4 out, because the file is a stub." if GlassBox.live?
GlassBox.print_cost(mixed)
