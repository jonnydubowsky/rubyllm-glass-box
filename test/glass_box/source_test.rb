# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../lib/glass_box/learn"

class SourceTest < Minitest::Test
  ROOTS = %w[lib demos guided docs bin test README.md .env.example .github].freeze
  DASHES = ["\u2014", "\u2013"].freeze

  def test_public_prose_has_no_em_dash
    offenders = []
    ROOTS.each do |relative|
      path = GlassBox::ROOT.join(relative)
      files = path.file? ? [path] : path.find.select(&:file?)
      files.each do |file|
        next if file.extname == ".png" || file.extname == ".pdf" || file.extname == ".mp4" || file.extname == ".wav"

        text = file.read
        offenders << file.to_s if DASHES.any? { |dash| text.include?(dash) }
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
      assert_includes lesson.read, "bin/learn #{step[:n]}\n"
      assert_includes readme.read, "bin/demo #{format('%02d', step[:n])}\n"
    end
  end

  # The course prose is in the third person or addresses the reader as "you".
  def test_markdown_prose_has_no_first_person_plural
    offenders = []
    Dir[GlassBox::ROOT.join("{README.md,docs/**/*.md,guided/**/*.md,demos/**/*.md}").to_s].each do |file|
      prose = File.read(file).gsub(/```.*?```/m, "").gsub(/`[^`]*`/, "")
      offenders << file if prose.match?(/\b(we|our|ours|us)\b/i)
    end
    assert_empty offenders
  end

  def test_every_demo_readme_has_its_own_what_to_look_at_section
    sections = GlassBox::Learn::STEPS.map do |step|
      text = GlassBox::ROOT.join("demos/#{step[:slug]}/README.md").read
      assert_includes text, "## What a live run sends", step[:slug]
      text[/^## What to look at\n\n(.+?)\n\nDocs:/m, 1] or flunk("#{step[:slug]} has no What to look at section")
    end
    assert_equal sections.size, sections.uniq.size, "two demo READMEs share the same What to look at text"
  end
end
