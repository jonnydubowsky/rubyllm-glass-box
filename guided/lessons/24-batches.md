# 24. Batches of chats

`ask_later` stages a message and does not send it. A batch is a set of those chats submitted together. Results come back later, so this is the wrong tool when you need the answer before the next line of the program.

The step stages three help-article lines from the catalog and prints each staged user message. `RubyLLM.batch` runs only when `GLASS_BOX_MODE=live` and `GLASS_BOX_BATCH=1`. Otherwise the log says the batch was not submitted.

Approval of a single tool call is a different pause. That is `question.approve` in step 14, or `chat.approve(tool_call)`.

## Run

```
bin/learn run 24
ruby demos/24-batches/run.rb
```

Docs: https://rubyllm.com/batches/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
