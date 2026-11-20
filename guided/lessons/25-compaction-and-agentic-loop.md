# 25. Compaction and the agentic loop

`with_compaction(at:)` sets the token count at which the gem shrinks the history. `ask_later` queues the user message. Each `chat.step` call runs one part of the loop, which is the model's turn, the tool, or the model's next turn. The loop stops when `complete?` or `waiting?` returns true.

The learner's question is how many episodes Room 4B has. The tool returns Copperframe, 12 episodes and the logline. The step prints a threshold of 50_000. The transcript is short, so compaction never rewrites it, and `chat.compaction` still shows the setting.

Read the step numbers and the tool result. The episode count comes from the result hash.

## Run

```
bin/learn run 25
ruby demos/25-compaction-and-agentic-loop/run.rb
```

Docs: https://rubyllm.com/agentic-workflows/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
