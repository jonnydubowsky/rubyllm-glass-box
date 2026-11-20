# 26. The model registry and token counting

This demo looks up `claude-sonnet-5` and `gemini-3.8-flash` with `RubyLLM.models.find` and asks `supports?` about vision, reasoning, citations, video, caching, function calling and structured output. It reads the registry from local data, and it runs `count_tokens` only in live mode. Offline, the script quotes the tour's "5 tokens" and states that it did not compute that number.

## Run

```
GLASS_BOX_MODE=offline bin/demo 26
```

You can also run `ruby demos/26-model-registry-and-tokens/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/models/

Guided lesson: `guided/lessons/26-model-registry-and-tokens.md`
