# 25. Compaction and the agentic loop

`with_compaction(at:)` sets a token threshold for shrinking history. `ask_later` queues the user message. `chat.step` runs one beat of the loop: the model turn, the tool, or the next model turn. You stop when `complete?` or `waiting?` is true.

The question is how many episodes Room 4B has. The tool returns Copperframe, 12 episodes, and the logline. The threshold printed here is 50_000. The transcript is short, so compaction does not rewrite it. The setting is still visible on `chat.compaction`.

Look at the step numbers and the tool result. The episode count is in the result hash.

## Run

```
bin/learn run 25
ruby demos/25-compaction-and-agentic-loop/run.rb
```

Docs: https://rubyllm.com/agentic-workflows/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
