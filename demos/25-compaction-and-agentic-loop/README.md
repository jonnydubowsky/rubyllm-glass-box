# 25. Compaction and the agentic loop

This demo sets `with_compaction(at: 50_000)`, calls `ask_later` and then calls `chat.step` until the chat reports `complete?` or `waiting?`. The tool looks up The Last Lantern in the fictional catalog and returns 48 episodes. The demo prints the compaction threshold, which this short transcript never reaches.

## Run

```
GLASS_BOX_MODE=offline bin/demo 25
```

You can also run `ruby demos/25-compaction-and-agentic-loop/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends chat requests to your default chat model until the model has answered. The tool reads the local catalog.

## What to look at

`[compaction]` prints the threshold of 50000. Each `step` line is one `chat.step` call. Offline there are three. The first is the assistant turn that calls the tool, the second is the tool result, and the third is the assistant's answer with `state=complete`.

Docs: https://rubyllm.com/agentic-workflows/

Guided lesson: `guided/lessons/25-compaction-and-agentic-loop.md`
