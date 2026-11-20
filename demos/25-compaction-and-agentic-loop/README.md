# 25. Compaction and the agentic loop

This demo sets `with_compaction(at: 50_000)`, calls `ask_later` and then calls `chat.step` until the chat reports `complete?` or `waiting?`. The tool looks up The Last Lantern in the fictional catalog and returns 48 episodes. The demo prints the compaction threshold, which this short transcript never reaches.

## Run

```
GLASS_BOX_MODE=offline bin/demo 25
```

You can also run `ruby demos/25-compaction-and-agentic-loop/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/agentic-workflows/

Guided lesson: `guided/lessons/25-compaction-and-agentic-loop.md`
