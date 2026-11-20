# 22. Extended thinking and provider web search

`with_thinking(effort: :high)` and `with_provider_tools(:web_search)` are chat settings you can print before the request. The effort value on this gem is the symbol you passed.

Web search is not available on every model. The call is rescued when the gem raises `UnsupportedServerToolError` or another `RubyLLM::Error`, and the log shows the class and message. The thinking setting remains on the chat.

Offline citations on the stubbed message are empty. A recorded citation about Ruby is printed underneath and labeled as not from this response. Do not treat that card as `response.citations`.

## Run

```
bin/learn run 22
ruby demos/22-thinking-and-provider-tools/run.rb
```

Docs: https://rubyllm.com/thinking/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
