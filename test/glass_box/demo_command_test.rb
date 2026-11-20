# frozen_string_literal: true

require_relative "../test_helper"

# bin/demo is a bash script. These tests run it the way a learner types it.
class DemoCommandTest < Minitest::Test
  MCP_HEADER = "---- demos/08-mcp-linear ----"

  def demo(*args)
    env = ENV.to_h.merge("GLASS_BOX_MODE" => "offline")
    env.delete("GLASS_BOX_APPROVE")
    Open3.capture2e(env, "bin/demo", *args, chdir: GlassBox::ROOT.to_s)
  end

  def headers(output)
    output.lines.map(&:chomp).grep(/\A---- demos\/.+ ----\z/)
  end

  def test_all_runs_the_27_numbered_demos_in_order
    output, status = demo("all")
    assert status.success?, output[-1500..]
    expected = GlassBox::Learn::STEPS.map { |step| "---- demos/#{step[:slug]} ----" }
    assert_equal expected, headers(output)
    refute_includes output, "demos/fixtures"
  end

  def test_a_zero_padded_number_runs_one_demo
    output, status = demo("08")
    assert status.success?, output
    assert_equal [MCP_HEADER], headers(output)
  end

  def test_a_bare_number_runs_the_same_demo
    output, status = demo("8")
    assert status.success?, output
    assert_equal [MCP_HEADER], headers(output)
  end

  def test_a_folder_name_runs_that_demo
    output, status = demo("08-mcp-linear")
    assert status.success?, output
    assert_equal [MCP_HEADER], headers(output)
  end

  def test_a_path_with_a_trailing_slash_runs_that_demo
    output, status = demo("demos/08-mcp-linear/")
    assert status.success?, output
    assert_equal [MCP_HEADER], headers(output)
  end

  def test_an_unknown_number_fails_and_names_the_range
    output, status = demo("99")
    refute status.success?
    assert_empty headers(output)
    assert_includes output, "No demo has the number 99"
    assert_includes output, "01 to 27"
  end

  def test_zero_fails
    output, status = demo("0")
    refute status.success?
    assert_includes output, "No demo has the number 0"
  end

  def test_the_fixtures_folder_is_not_a_demo
    output, status = demo("fixtures")
    refute status.success?
    assert_empty headers(output)
    assert_includes output, "No demo matches 'fixtures'"
  end

  def test_an_unknown_name_fails
    output, status = demo("weather")
    refute status.success?
    assert_includes output, "No demo matches 'weather'"
  end

  def test_no_argument_prints_usage_and_fails
    output, status = demo
    refute status.success?
    assert_includes output, "Usage: bin/demo"
  end

  def test_list_prints_the_27_folder_names
    output, status = demo("list")
    assert status.success?, output
    assert_equal GlassBox::Learn::STEPS.map { |step| step[:slug] }, output.lines.map(&:chomp)
  end
end
