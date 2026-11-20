# 01. A raw provider request next to RubyLLM

The tour opens on a curl call to OpenAI's Responses API. In that response, the assistant's sentence sits two levels deep, inside a content part of type `output_text` within an output item of type `message`. The first output item is often a reasoning item, so code that reads `output[0]` can miss the sentence.

This step builds that response shape in memory for one catalog question and never sends the curl. It then calls `chat.ask` with the same prompt. The publisher in the answer is Lantern Reel, the company the catalog lists for The Last Lantern.

Read the log line `curl (not sent)`, then the text taken from the message item, then `chat.cost.total`. Offline, the stub supplies the cost. Later in the course, some costs are nil, and a nil cost is different from zero.

With `GLASS_BOX_MODE=live` and an OpenAI key, the demo's `chat.ask` calls the provider. The step still never sends the curl.

## Run

```
bin/learn run 1
ruby demos/01-curl-contrast/run.rb
```

Docs: https://rubyllm.com/getting-started/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
