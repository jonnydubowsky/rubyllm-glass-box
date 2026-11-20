# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../lib/glass_box/learn"

class SourceTest < Minitest::Test
  ROOTS = %w[lib demos guided bin README.md .env.example .github].freeze

  def test_public_prose_has_no_em_dash
    offenders = []
    ROOTS.each do |relative|
      path = GlassBox::ROOT.join(relative)
      files = path.file? ? [path] : path.find.select(&:file?)
      files.each do |file|
        next if file.extname == ".png" || file.extname == ".pdf" || file.extname == ".mp4" || file.extname == ".wav"

        text = file.read
        offenders << file.to_s if text.include?("—") || text.include?("–")
      end
    end
    assert_empty offenders
  end

  def test_lessons_and_demo_readmes_exist
    GlassBox::Learn::STEPS.each do |step|
      lesson = GlassBox::ROOT.join("guided/lessons/#{step[:slug]}.md")
      readme = GlassBox::ROOT.join("demos/#{step[:slug]}/README.md")
      assert lesson.file?, lesson.to_s
      assert readme.file?, readme.to_s
      assert_includes lesson.read, "bin/learn run #{step[:n]}"
    end
  end
end
