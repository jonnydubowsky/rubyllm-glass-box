# 26. The model registry and token counting

`RubyLLM.models.find` reads the bundled registry and needs no network. The step prints `claude-sonnet-5` and `gemini-3.8-flash` with their providers and whether each supports vision and structured output. The demo prints a longer list of capabilities, with `supports?` for reasoning, citations, video, caching and function calling.

`chat.count_tokens` asks the provider for a count, and offline the step never calls it. The tour card shows 5 tokens for "Ruby is elegant and expressive". The step neither computes that 5 nor prints 0 in its place.

In live mode, with a chat provider configured, the step logs the integer the provider returns.

## Run

```
bin/learn run 26
ruby demos/26-model-registry-and-tokens/run.rb
```

Docs: https://rubyllm.com/models/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
