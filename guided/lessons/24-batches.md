# 24. Batches of chats

`ask_later` stages a message without sending it, and a batch submits a set of those chats together. The results arrive later, so a batch is the wrong choice when the program needs the answer before its next line.

This step stages three help-article lines from the catalog and prints each staged user message. `RubyLLM.batch` runs only when `GLASS_BOX_MODE=live` and `GLASS_BOX_BATCH=1` are both set. Otherwise, the log says the step didn't submit the batch.

Approving a single tool call is a different kind of pause. Step 14 handles it with `question.approve`, and `chat.approve(tool_call)` also works.

## Run

```
bin/learn run 24
ruby demos/24-batches/run.rb
```

Docs: https://rubyllm.com/batches/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
