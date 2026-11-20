# 11. Typed judgments with probabilities and choices

A `RubyLLM::Judge` asks for a probability and a choice, each with the model's confidence. The tour also shows `model "clef-flash", provider: :ollama`. That id is not in the bundled registry until Ollama is running and the registry is refreshed, so this course does not call it.

The default judgment model is TypeSafe `jev-latest`. With no TypeSafe key, a live OpenAI key uses `gpt-6-luna`, then a Gemini key uses `gemini-decision-1`. Otherwise you get a `RubyLLM::Judgment` built in process: urgent 0.97, department billing, confidence 0.91. The log says the judge was not called.

The judgment routes a fictional playback ticket. It does not score a brand. Lantern Reel's 68.5 and Emerging Power are printed from the scorer on the next line so the two systems stay separate.

## Run

```
bin/learn run 11
ruby demos/11-judgments/run.rb
```

Docs: https://rubyllm.com/judgments/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
