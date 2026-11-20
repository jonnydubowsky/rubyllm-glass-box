#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "17  Image and video generation"

prompt = "A red panda writing Ruby"
dir = GlassBox.output_dir("17-image-video-generation")
image = GlassBox.paint(prompt)
image_path = dir.join("panda.png")
image.save(image_path.to_s)
video = GlassBox.animate(prompt)
video_path = dir.join("panda.mp4")
video.save(video_path.to_s)
GlassBox.log "prompt", prompt
GlassBox.log "image", "#{image_path} model=#{image.model} bytes=#{File.size(image_path)}"
GlassBox.log "video", "#{video_path} model=#{video.model} bytes=#{File.size(video_path)}"
