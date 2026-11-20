# 04. Streaming tokens with a block

## The concept

When you pass a block to `ask`, the gem calls the block once for each chunk of the reply as it arrives. `chunk.content` holds only the text that arrived in that chunk. `ask` still returns the complete reply when the stream ends.

## What this step does

The step sends this prompt and prints each chunk as it arrives: "Distribution Power has a weight of 0.25, the largest of the five weights. Write one sentence that says so." The weight comes from `GlassBox::SBPI`. Offline, the test helper splits the scripted sentence into words and pauses briefly between them. Those words stand in for a provider's deltas.

## What to look at

Watch the `stream:` line grow as chunks arrive. Then check the weight in the sentence against the weight in the prompt. `demos/04-streaming` passes the same kind of block with the tour's haiku prompt.

## Run

```
bin/learn 4
GLASS_BOX_MODE=offline bin/demo 4
```

`bin/learn 4` prints this lesson and then runs the step. `bin/demo 4` runs the standalone demo in `demos/04-streaming`.

Docs: https://rubyllm.com/streaming/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
