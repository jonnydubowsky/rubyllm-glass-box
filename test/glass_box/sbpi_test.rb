# frozen_string_literal: true

require_relative "../test_helper"

class SBPITest < Minitest::Test
  def test_weights_sum_to_one
    total = GlassBox::SBPI::DIMENSIONS.sum { |dimension| dimension[:weight] }
    assert_in_delta 1.0, total, 0.000_001
  end

  def test_distribution_power_is_the_heaviest_weight
    weights = GlassBox::SBPI::DIMENSIONS.map { |dimension| dimension[:weight] }
    assert_equal 0.25, GlassBox::SBPI.dimension("distribution_power")[:weight]
    assert_equal 0.25, weights.max
  end

  def test_band_boundaries
    assert_equal "Category Dominant", GlassBox::SBPI.band(85)
    assert_equal "Category Dominant", GlassBox::SBPI.band(100)
    assert_equal "Strong Ecosystem Player", GlassBox::SBPI.band(84)
    assert_equal "Strong Ecosystem Player", GlassBox::SBPI.band(70)
    assert_equal "Emerging Power", GlassBox::SBPI.band(69)
    assert_equal "Emerging Power", GlassBox::SBPI.band(55)
    assert_equal "Niche Player", GlassBox::SBPI.band(54)
    assert_equal "Niche Player", GlassBox::SBPI.band(40)
    assert_equal "Limited Structural Presence", GlassBox::SBPI.band(39)
    assert_equal "Limited Structural Presence", GlassBox::SBPI.band(0)
  end

  def test_catalog_composites
    expected = {
      "Lantern Reel" => [68.5, "Emerging Power"],
      "Night Bazaar" => [85.9, "Category Dominant"],
      "Harbor and Thorn" => [48.8, "Niche Player"],
      "Copperframe" => [30.75, "Limited Structural Presence"],
      "Kite Alley" => [62.3, "Emerging Power"]
    }
    expected.each do |name, (composite, band)|
      company = GlassBox.catalog.find_company(name)
      assert company, name
      assert_in_delta composite, company.composite, 0.001, name
      assert_equal band, company.band, name
    end
  end

  def test_inputs_outside_the_scale_raise
    scores = GlassBox.catalog.find_company("Lantern Reel").scores.dup
    scores["content_strength"] = 101
    assert_raises(ArgumentError) { GlassBox::SBPI.composite(scores) }
  end
end
