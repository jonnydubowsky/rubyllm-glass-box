# 21. Model fallbacks and prompt caching

This demo opens a chat on `claude-sonnet-5` with `with_fallbacks("claude-haiku-4-5")` and `with_caching(ttl: "1h")`. Offline, a stubbed `OverloadedError` triggers the fallback, and `response.model_id` changes to `claude-haiku-4-5`. The demo prints `cache_read` only when the response includes one, and it never fakes a cache hit. In live mode without an Anthropic key, the demo builds no chat and sends no request.

## Run

```
GLASS_BOX_MODE=offline bin/demo 21
```

You can also run `ruby demos/21-fallbacks-and-caching/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one chat request to Anthropic. The fallback model runs only if the first model fails.

## What to look at

`[caching config]` shows the `ttl`. `[fallback]` appears when the first model fails, and it names the model that takes over. `[response model]` then reads `claude-haiku-4-5`. `[cache]` reports a `cache_read` count only when the provider returned one.

Docs: https://rubyllm.com/error-handling/

Guided lesson: `guided/lessons/21-fallbacks-and-caching.md`
