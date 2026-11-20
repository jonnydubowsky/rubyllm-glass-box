# frozen_string_literal: true

require "base64"

module GlassBox
  module Fixtures
    module_function

    # A short local vector so a demo can print Embedding#vectors with no provider.
    # It is not a model embedding. The bytes of the text pick the numbers.
    def embedding(text)
      bytes = text.to_s.bytes
      bytes = [0] if bytes.empty?
      vectors = Array.new(8) { |index| ((bytes[index % bytes.length] - 96) / 100.0).round(4) }
      RubyLLM::Embedding.new(vectors: vectors, model: "offline-fixture")
    end

    def rerank(query, documents)
      terms = query.downcase.scan(/[a-z0-9]+/)
      ranked = documents.each_with_index.map do |document, index|
        words = document.downcase.scan(/[a-z0-9]+/)
        overlap = terms.count { |term| words.include?(term) }
        score = (overlap.to_f / terms.length).round(2)
        RubyLLM::Rerank::Result.new(index: index, document: document, score: score)
      end
      ranked.sort_by! { |result| [-result.score, result.index] }
      RubyLLM::Rerank.new(results: ranked, model: "offline-fixture")
    end

    def moderation(flagged:)
      RubyLLM::Moderation.new(
        id: "modr_offline",
        model: "offline-fixture",
        results: [
          RubyLLM::Moderation::Result.new(flagged: flagged, categories: [], category_scores: {})
        ]
      )
    end

    def ocr(markdown)
      RubyLLM::OCR.new(
        pages: [{ "index" => 0, "markdown" => markdown }],
        model: "offline-fixture"
      )
    end

    def judgment_ticket
      RubyLLM::Judgment.new(
        answers: {
          urgent: RubyLLM::Probability.new(probability: 0.97),
          department: RubyLLM::Choice.new(
            choice: :billing,
            probabilities: { billing: 0.91, technical: 0.06, other: 0.03 },
            confidence: 0.91
          )
        },
        model: "offline-fixture"
      )
    end

    def speech(_text)
      # A silent WAV so Speech#save has bytes. It is not a synthesis of the sentence.
      RubyLLM::Speech.new(data: silent_wav, model: "offline-fixture", voice: "fixture", format: "wav")
    end

    def transcription(text)
      RubyLLM::Transcription.new(text: text, model: "offline-fixture", language: "en", duration: 0.2)
    end

    def image(prompt)
      png = File.binread(GlassBox::ROOT.join("demos/fixtures/pixel.png"))
      RubyLLM::Image.new(
        data: Base64.strict_encode64(png),
        mime_type: "image/png",
        revised_prompt: prompt,
        model: "offline-fixture"
      )
    end

    def video(prompt)
      RubyLLM::Video.new(
        data: "fixture-video:#{prompt}".b,
        mime_type: "video/mp4",
        model: "offline-fixture",
        duration: 0
      )
    end

    def recorded_citation
      RubyLLM::Citation.new(
        title: "recorded card",
        cited_text: "Ruby was created by Yukihiro Matsumoto in 1993, as a language for programmer joy."
      )
    end

    def silent_wav
      samples = 1600
      data = "\x00\x00".b * samples
      header = [
        "RIFF",
        [36 + data.bytesize].pack("V"),
        "WAVE",
        "fmt ",
        [16].pack("V"),
        [1].pack("v"),
        [1].pack("v"),
        [8000].pack("V"),
        [16000].pack("V"),
        [2].pack("v"),
        [16].pack("v"),
        "data",
        [data.bytesize].pack("V")
      ].join
      header.b + data
    end
  end
end
