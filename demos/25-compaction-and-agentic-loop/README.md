# 25. Compaction and the agentic loop

`with_compaction(at: 50_000)`, `ask_later`, then `chat.step` until `complete?` or `waiting?`. The tool looks up The Last Lantern in the synthetic catalog and returns 48 episodes. The compaction threshold is printed. This short transcript does not cross it.

## Run

```
ruby demos/25-compaction-and-agentic-loop/run.rb
```

Or `bin/demo 25`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/agentic-workflows/

Guided lesson: `guided/lessons/25-compaction-and-agentic-loop.md`
