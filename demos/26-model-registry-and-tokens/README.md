# 26. The model registry and token counting

`RubyLLM.models.find` for `claude-sonnet-5` and `gemini-3.8-flash`, then `supports?` for vision, reasoning, citations, video, caching, function calling, and structured output. The registry read is local. `count_tokens` runs only when live. Offline, the script quotes the tour's "5 tokens" and states that this process did not compute it.

## Run

```
ruby demos/26-model-registry-and-tokens/run.rb
```

Or `bin/demo 26`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/models/

Guided lesson: `guided/lessons/26-model-registry-and-tokens.md`
