# 01. A raw provider request next to RubyLLM

The tour opens on a curl call to OpenAI's Responses API. The assistant sentence is nested: an output item with type `message`, then a content part with type `output_text`. The first output item is often reasoning, so `output[0]` is the wrong place to read.

This step builds that shape in memory for one catalog question and does not send the curl. It then calls `chat.ask` with the same prompt. The publisher name is the catalog row for The Last Lantern, which is Lantern Reel.

Look at the log line `curl (not sent)`, the text taken from the message item, and `chat.cost.total`. Offline, the stub supplies the cost. A nil cost later in the course is not zero.

With `GLASS_BOX_MODE=live` and an OpenAI key, the demo's `chat.ask` calls the provider. The curl is still not sent.

## Run

```
bin/learn run 1
ruby demos/01-curl-contrast/run.rb
```

Docs: https://rubyllm.com/getting-started/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
