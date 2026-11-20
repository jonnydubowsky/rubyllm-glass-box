# 21. Model fallbacks and prompt caching

A chat on `claude-sonnet-5` with `with_fallbacks("claude-haiku-4-5")` and `with_caching(ttl: "1h")`. Offline, an `OverloadedError` stub trips the fallback and `response.model_id` becomes `claude-haiku-4-5`. `cache_read` is printed only when the response has one. This demo does not invent a cache hit. Live, the ask is skipped when Anthropic is not configured.

## Run

```
ruby demos/21-fallbacks-and-caching/run.rb
```

Or `bin/demo 21`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/error-handling/

Guided lesson: `guided/lessons/21-fallbacks-and-caching.md`
