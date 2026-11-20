# 24. Batches of chats

## The concept

`ask_later` stages a message on a chat without sending it. `RubyLLM.batch` submits a set of staged chats to the provider as one batch and returns a batch id. The results arrive later, so a batch is the wrong choice when the program needs the answer before its next line.

## What this step does

The step stages three chats, one for each of the first three help articles in the catalog. Each chat has the instructions "Answer with one word: account, billing, or playback." and a staged message that starts with "Classify this help line:". The step prints each staged message.

`RubyLLM.batch` runs only when `GLASS_BOX_MODE=live` and `GLASS_BOX_BATCH=1` are both set. Otherwise, the log says the step didn't submit the batch.

## What to look at

Each `staged` line shows a user message that no provider has received yet. The last line says whether the step submitted the batch. Approving a single tool call is a different kind of pause. Step 14 handles it with `question.approve`, and `chat.approve(tool_call)` also works.

## Run

```
bin/learn 24
GLASS_BOX_MODE=offline bin/demo 24
```

`bin/learn 24` prints this lesson and then runs the step. `bin/demo 24` runs the standalone demo in `demos/24-batches`.

Docs: https://rubyllm.com/batches/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
