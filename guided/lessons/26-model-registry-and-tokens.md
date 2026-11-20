# 26. The model registry and token counting

`RubyLLM.models.find` reads the bundled registry. No network. The step prints `claude-sonnet-5` and `gemini-3.8-flash`, the provider, and whether each supports vision and structured output. The demo prints a longer capability list, including `supports?` for reasoning, citations, video, caching, and function calling.

`chat.count_tokens` asks the provider for a count. Offline, it is not called. The tour card shows 5 tokens for "Ruby is elegant and expressive". This process does not compute that 5, and it does not print 0 in its place.

Live, with a configured chat provider, the step logs whatever integer the provider returns.

## Run

```
bin/learn run 26
ruby demos/26-model-registry-and-tokens/run.rb
```

Docs: https://rubyllm.com/models/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
