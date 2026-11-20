# frozen_string_literal: true

require_relative "../test_helper"

class ProgramsTest < Minitest::Test
  def test_each_demo_exits_zero_offline
    Dir[GlassBox::ROOT.join("demos/*/run.rb").to_s].sort.each do |script|
      output, status = GlassBoxTest.run_ruby(script, unset: ["GLASS_BOX_APPROVE"])
      assert status.success?, "#{script}\n#{output[-1500..]}"
    end
  end

  def test_learn_auto_exits_zero_offline
    output, status = GlassBoxTest.run_ruby("bin/learn", "auto")
    assert status.success?, output[-2000..]
    assert_includes output, "Checkpoint 27 saved."
  end
end
