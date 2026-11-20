# 21. Model fallbacks and prompt caching

This demo opens a chat on `claude-sonnet-5` with `with_fallbacks("claude-haiku-4-5")` and `with_caching(ttl: "1h")`. Offline, a stubbed `OverloadedError` triggers the fallback, and `response.model_id` changes to `claude-haiku-4-5`. The demo prints `cache_read` only when the response includes one, and it never fakes a cache hit. In live mode, the demo skips the ask when Anthropic is not configured.

## Run

```
GLASS_BOX_MODE=offline bin/demo 21
```

You can also run `ruby demos/21-fallbacks-and-caching/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/error-handling/

Guided lesson: `guided/lessons/21-fallbacks-and-caching.md`
