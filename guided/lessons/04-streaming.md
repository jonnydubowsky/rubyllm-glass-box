# 04. Streaming tokens with a block

A block on `ask` receives chunks. `chunk.content` is the new text, not the whole answer so far.

The sentence names Distribution Power and the weight from `GlassBox::SBPI`, which is 0.25. That weight is the largest of the five. The program prints each chunk as it arrives. Offline, the test helper splits the stubbed sentence on words, so the pieces are a stand-in for provider deltas, and the words are still the ones the program queued.

Look at the `stream:` line growing, and at the demo, which uses the same block on a shorter prompt.

## Run

```
bin/learn run 4
ruby demos/04-streaming/run.rb
```

Docs: https://rubyllm.com/streaming/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
