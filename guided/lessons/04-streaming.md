# 04. Streaming tokens with a block

When you pass a block to `ask`, the block receives each chunk. `chunk.content` holds only the text that arrived in that chunk.

The sentence in this step names Distribution Power and its weight in `GlassBox::SBPI`, 0.25, the largest of the five weights. The program prints each chunk as it arrives. Offline, the test helper splits the scripted sentence into words. Those words stand in for a provider's deltas, and they are still the words the program queued.

Watch the `stream:` line grow as chunks arrive. The demo uses the same block on a shorter prompt.

## Run

```
bin/learn run 4
ruby demos/04-streaming/run.rb
```

Docs: https://rubyllm.com/streaming/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
