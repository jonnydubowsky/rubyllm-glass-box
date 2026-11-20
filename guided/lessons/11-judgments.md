# 11. Typed judgments with probabilities and choices

A `RubyLLM::Judge` asks the model for a probability and a choice, each with a confidence value. The tour also shows `model "clef-flash", provider: :ollama`. That model id stays out of the bundled registry until Ollama is running and the registry is refreshed, so this course never calls it.

The default judgment model is TypeSafe `jev-latest`. Without a TypeSafe key, the step uses OpenAI `gpt-6-luna` if an OpenAI key is set, and then Gemini `gemini-decision-1` if a Gemini key is set. With none of those keys, the step builds a `RubyLLM::Judgment` in the same process, with urgent at 0.97, department billing and confidence 0.91. The log says the step did not call the judge.

The judgment routes a fictional support ticket about playback and scores no brand. On the next line, the scorer prints Lantern Reel's composite of 68.5 and its band, Emerging Power, so the two systems stay separate.

## Run

```
bin/learn run 11
ruby demos/11-judgments/run.rb
```

Docs: https://rubyllm.com/judgments/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
