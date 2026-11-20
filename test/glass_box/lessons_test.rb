# frozen_string_literal: true

require_relative "../test_helper"

# Each lesson teaches the concept first, then says what the step does, then
# says what to look at. bin/learn prints those sections before it runs a step.
class LessonsTest < Minitest::Test
  Learn = GlassBox::Learn

  def lesson(step)
    Learn::LESSONS.join("#{step[:slug]}.md").read
  end

  def test_every_lesson_has_the_teaching_sections_in_order_above_run
    Learn::STEPS.each do |step|
      text = lesson(step)
      headings = text.lines.map(&:chomp).grep(/\A## /)
      assert_equal Learn::LESSON_SECTIONS + ["## Run"], headings, step[:slug]
      assert_equal "# #{format('%02d', step[:n])}. #{step[:title]}", text.lines.first.chomp, step[:slug]
    end
  end

  def test_every_teaching_section_has_text
    Learn::STEPS.each do |step|
      sections = lesson(step).split(/^## .*$/)
      sections[1, 3].each { |body| assert_operator body.strip.length, :>, 80, step[:slug] }
    end
  end

  def test_each_lesson_quotes_every_prompt_its_step_sends
    Learn.prompts.each do |number, strings|
      step = Learn.find_step(number)
      body = Learn.lesson_body(step)
      strings.each do |string|
        assert_includes body, string, "#{step[:slug]} does not quote the step's prompt"
      end
    end
  end

  def test_steps_with_no_prompt_say_so_in_the_lesson
    silent = Learn::STEPS.map { |step| step[:n] } - Learn.prompts.keys
    assert_equal [8, 12, 20, 27], silent
    silent.each do |number|
      step = Learn.find_step(number)
      assert_includes Learn.lesson_body(step), "No prompt goes to a model", step[:slug]
    end
  end

  def test_lessons_address_the_reader_as_you
    Learn::STEPS.each do |step|
      refute_match(/\bthe learner\b/i, lesson(step), step[:slug])
    end
  end

  def test_learn_prints_the_lesson_before_the_step_output
    output, status = GlassBoxTest.run_ruby("bin/learn", "2")
    assert status.success?, output
    concept = output.index("THE CONCEPT")
    look = output.index("WHAT TO LOOK AT")
    step_output = output.index("---- step 2 output ----")
    # The lesson text names the [reply] label too, so take the last one.
    reply = output.rindex("[reply]")
    assert concept && look && step_output && reply, output
    assert_operator concept, :<, look
    assert_operator look, :<, step_output
    assert_operator step_output, :<, reply
  end

  def test_learn_auto_prints_no_lesson_text
    output, status = GlassBoxTest.run_ruby("bin/learn", "auto")
    assert status.success?, output[-2000..]
    refute_includes output, "THE CONCEPT"
    assert_includes output, "Checkpoint 27 saved."
  end

  def test_learn_wraps_lesson_lines_for_a_terminal
    text = Learn.lesson_for_terminal(Learn.find_step(1))
    assert_operator text.lines.map { |line| line.chomp.length }.max, :<=, Learn::WRAP
  end

  def test_learn_rejects_a_step_that_does_not_exist
    ["99", "0", "banana"].each do |argument|
      output, status = GlassBoxTest.run_ruby("bin/learn", argument)
      refute status.success?, argument
      assert_includes output, "No step matches '#{argument}'"
    end
  end
end
