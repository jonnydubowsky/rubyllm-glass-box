# 21. Model fallbacks and prompt caching

`with_fallbacks` names the next model. `with_caching(ttl:)` marks a cache boundary. The tour shows a cache hit. This course prints `response.tokens.cache_read` only when the provider reports one. It does not print a hit on its own. A missing read is not zero.

Offline, the stub raises `RubyLLM::OverloadedError` and then returns a sentence. The chat started on `claude-sonnet-5` and the reply's `model_id` is `claude-haiku-4-5`. `chat.model.id` stays the model you asked for. The sentence names Harbor and Thorn's band from the scorer.

Live, the request is sent only when Anthropic is configured. The caching config is printed either way.

## Run

```
bin/learn run 21
ruby demos/21-fallbacks-and-caching/run.rb
```

Docs: https://rubyllm.com/error-handling/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
