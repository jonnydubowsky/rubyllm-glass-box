# frozen_string_literal: true

module GlassBox
  module_function

  def embed(text)
    boot!
    if live? && provider_configured?(:openai)
      log("provider", "RubyLLM.embed")
      RubyLLM.embed(text)
    else
      log("fixture", "RubyLLM.embed was not called. This vector is a local stand-in, not a model embedding.")
      Fixtures.embedding(text)
    end
  end

  def rerank(query, documents, model: "rerank-v3.5")
    boot!
    if live? && provider_configured?(:cohere)
      log("provider", "RubyLLM.rerank model=#{model} provider=cohere")
      RubyLLM.rerank(query, documents, model: model, provider: :cohere)
    elsif live? && present?(ENV["RUBYLLM_RERANK_MODEL"])
      provider = ENV["RUBYLLM_RERANK_PROVIDER"]&.strip&.downcase&.to_sym
      log("provider", "RubyLLM.rerank model=#{ENV["RUBYLLM_RERANK_MODEL"]} provider=#{provider}")
      RubyLLM.rerank(query, documents, model: ENV["RUBYLLM_RERANK_MODEL"], provider: provider)
    else
      log("fixture", "RubyLLM.rerank was not called. Scores are keyword overlap in this process.")
      Fixtures.rerank(query, documents)
    end
  end

  def moderate(text)
    boot!
    if live? && provider_configured?(:openai)
      log("provider", "RubyLLM.moderate")
      RubyLLM.moderate(text)
    else
      log("fixture", "RubyLLM.moderate was not called. flagged? below is a local stand-in for this benign string.")
      Fixtures.moderation(flagged: false)
    end
  end

  def ocr(path)
    boot!
    if live? && provider_configured?(:mistral)
      log("provider", "RubyLLM.ocr")
      RubyLLM.ocr(path)
    else
      log("fixture", "RubyLLM.ocr was not called. Markdown below is the text this course put in the file.")
      Fixtures.ocr(File.read(ROOT.join("demos/fixtures/terms.md")))
    end
  end

  def speak(text)
    boot!
    if live? && (provider_configured?(:openai) || provider_configured?(:elevenlabs))
      log("provider", "RubyLLM.speak")
      RubyLLM.speak(text)
    else
      log("fixture", "RubyLLM.speak was not called. The file is a silent WAV, not spoken audio.")
      Fixtures.speech(text)
    end
  end

  def transcribe(path, expected_text:)
    boot!
    if live? && provider_configured?(:openai)
      log("provider", "RubyLLM.transcribe")
      RubyLLM.transcribe(path)
    else
      log("fixture", "RubyLLM.transcribe was not called. The text below is the source sentence, not a transcript of the file.")
      Fixtures.transcription(expected_text)
    end
  end

  def paint(prompt)
    boot!
    if paid_media? && live? && provider_configured?(:openai)
      log("provider", "RubyLLM.paint")
      RubyLLM.paint(prompt)
    elsif paid_media? && live? && present?(ENV["RUBYLLM_IMAGE_MODEL"])
      log("provider", "RubyLLM.paint model=#{ENV["RUBYLLM_IMAGE_MODEL"]}")
      RubyLLM.paint(prompt, model: ENV["RUBYLLM_IMAGE_MODEL"], provider: ENV["RUBYLLM_IMAGE_PROVIDER"]&.to_sym)
    else
      log("fixture", "RubyLLM.paint was not called. The PNG is a single fixture pixel, not a generated picture. Set GLASS_BOX_PAID_MEDIA=1 to call the provider.")
      Fixtures.image(prompt)
    end
  end

  def animate(prompt)
    boot!
    if paid_media? && live? && provider_configured?(:xai)
      log("provider", "RubyLLM.animate")
      RubyLLM.animate(prompt)
    else
      log("fixture", "RubyLLM.animate was not called. The file is a text stand-in, not a video. Set GLASS_BOX_PAID_MEDIA=1 and XAI_API_KEY to render.")
      Fixtures.video(prompt)
    end
  end

  def judge_ticket(judge_class, text)
    boot!
    if live? && provider_configured?(:typesafe)
      log("provider", "#{judge_class}.judge with the default judgment model")
      judge_class.judge(text)
    elsif live? && provider_configured?(:openai)
      log("provider", "#{judge_class}.judge model=gpt-6-luna")
      judge_class.judge(text, model: "gpt-6-luna", provider: :openai)
    elsif live? && provider_configured?(:gemini)
      log("provider", "#{judge_class}.judge model=gemini-decision-1")
      judge_class.judge(text, model: "gemini-decision-1", provider: :gemini)
    else
      log("fixture", "#{judge_class}.judge was not called. The numbers below are a recorded card built with RubyLLM::Judgment.")
      Fixtures.judgment_ticket
    end
  end
end
