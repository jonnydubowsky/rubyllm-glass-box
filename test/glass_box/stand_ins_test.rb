# frozen_string_literal: true

require_relative "../test_helper"
require "ruby_llm/test_helper"

# The course uses local stand-ins wherever RubyLLM's test helper has no stub.
# These tests fail when a new ruby_llm release changes what the helper covers,
# which is the moment to replace a stand-in with the gem's own stub.
class StandInsTest < Minitest::Test
  REVIEW = "RubyLLM's test helper changed. Read lib/ruby_llm/test_helper.rb in the new gem, " \
           "replace any stand-in in lib/glass_box/calls.rb that the helper now covers, " \
           "and update 'Where the demos use stand-ins' in README.md."

  def test_the_gem_version_is_the_one_the_course_documents
    assert_equal "2.2.3", RubyLLM::VERSION
    assert_includes GlassBox::ROOT.join("README.md").read, "`ruby_llm` 2.2.3"
  end

  def test_the_test_helper_still_scripts_chat_replies_only
    assert_equal %i[after_teardown stub_replies tool_call],
                 RubyLLM::TestHelper.public_instance_methods(false).sort, REVIEW
    assert_equal %i[complete],
                 RubyLLM::TestHelper::StubbedProvider.public_instance_methods(false).sort, REVIEW
  end

  def test_the_embedding_stand_in_has_the_shape_of_a_real_embedding
    one = GlassBox::Fixtures.embedding("Ruby is elegant and expressive")
    assert_equal 8, one.vectors.length
    assert(one.vectors.all?(Numeric))
    assert_equal one.vectors, one.vector

    many = GlassBox::Fixtures.embedding(%w[first second third])
    assert_equal 3, many.vectors.length
    assert(many.vectors.all? { |vector| vector.length == 8 })
    assert_equal "offline-fixture", many.model
  end

  def test_the_rerank_stand_in_puts_the_password_articles_first
    rerank = GlassBox::Fixtures.rerank("How do I reset my password?", GlassBox.catalog.help_articles)
    top = rerank.results.first(2).map(&:document)
    assert_equal ["Reset your password in Settings.", "Use Forgot password to get a reset link."], top
  end

  def test_the_judgment_stand_in_takes_the_department_it_is_given
    billing = GlassBox::Fixtures.judgment_ticket
    assert_equal :billing, billing.department.choice
    technical = GlassBox::Fixtures.judgment_ticket(department: :technical)
    assert_equal :technical, technical.department.choice
    assert_in_delta 0.91, technical.department.confidence
    assert_in_delta 0.97, technical.urgent.probability
  end

  def test_every_stand_in_names_its_model_offline_fixture
    results = [
      GlassBox::Fixtures.moderation(flagged: false),
      GlassBox::Fixtures.ocr("# Title"),
      GlassBox::Fixtures.speech("line"),
      GlassBox::Fixtures.transcription("line"),
      GlassBox::Fixtures.image("prompt"),
      GlassBox::Fixtures.video("prompt")
    ]
    results.each { |result| assert_equal "offline-fixture", result.model, result.class.name }
  end
end
