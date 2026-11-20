# 26. The model registry and token counting

## The concept

RubyLLM ships a registry of models. `RubyLLM.models.find` reads it from local data and needs no network. Each model lists its provider and its capabilities, and `supports?` answers for one capability. `chat.count_tokens` asks the provider how many tokens a text uses, so it needs a live provider.

## What this step does

The step prints `claude-sonnet-5` and `gemini-3.8-flash` with their providers and whether each supports vision and structured output. It then takes this sentence: "Ruby is elegant and expressive". In live mode, with a chat provider configured, the step logs the integer the provider returns. Offline, the step never calls `count_tokens`.

## What to look at

Read the two registry lines. Under them, the offline run quotes the tour card's figure of 5 tokens and says that this process didn't compute it. The step never prints 0 in place of a count it doesn't have. `demos/26-model-registry-and-tokens` prints a longer list of capabilities.

## Run

```
bin/learn 26
GLASS_BOX_MODE=offline bin/demo 26
```

`bin/learn 26` prints this lesson and then runs the step. `bin/demo 26` runs the standalone demo in `demos/26-model-registry-and-tokens`.

Docs: https://rubyllm.com/models/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
