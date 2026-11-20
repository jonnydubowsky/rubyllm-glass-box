# 26. The model registry and token counting

This demo looks up `claude-sonnet-5` and `gemini-3.8-flash` with `RubyLLM.models.find` and asks `supports?` about vision, reasoning, citations, video, caching, function calling and structured output. It reads the registry from local data, and it runs `count_tokens` only in live mode. Offline, the script quotes the tour's "5 tokens" and states that it did not compute that number.

## Run

```
GLASS_BOX_MODE=offline bin/demo 26
```

You can also run `ruby demos/26-model-registry-and-tokens/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one token-count request to your default provider. The registry lookups need no network.

## What to look at

Each model prints its provider, its capability list and a `supports` line for seven capabilities. Compare them with the tour's card, which lists vision, reasoning and citations for `claude-sonnet-5`, and vision, video and caching for `gemini-3.8-flash`. Offline, the last lines quote the tour's 5 tokens and say that this process didn't count them.

Docs: https://rubyllm.com/models/

Guided lesson: `guided/lessons/26-model-registry-and-tokens.md`
