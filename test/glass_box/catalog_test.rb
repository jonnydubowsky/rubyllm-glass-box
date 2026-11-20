# frozen_string_literal: true

require_relative "../test_helper"

class CatalogTest < Minitest::Test
  def test_category_examples_are_not_scored_rows
    names = GlassBox.catalog.companies.map(&:name)
    refute_includes names, "ReelShort"
    refute_includes names, "DramaBox"
    assert_includes GlassBox.catalog.category_examples, "ReelShort"
    assert_includes GlassBox.catalog.category_examples, "DramaBox"
  end

  def test_every_company_has_five_inputs_and_a_title
    GlassBox.catalog.companies.each do |company|
      assert_equal 5, company.scores.size, company.name
      GlassBox::SBPI::DIMENSIONS.each do |dimension|
        assert company.scores.key?(dimension[:key]), company.name
      end
      refute_empty company.titles
    end
  end

  def test_title_lookup
    company, title = GlassBox.catalog.find_title("Salt Wedding")
    assert_equal "Harbor and Thorn", company.name
    assert_equal 24, title.episodes
  end
end
