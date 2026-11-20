# 04. Streaming tokens with a block

This demo passes a block to `ask` and prints each `chunk.content` as it arrives. Offline, the test helper splits the scripted haiku into words. Those words are the chunks the gem produces under the stub. A live provider sends its own deltas.

## Run

```
GLASS_BOX_MODE=offline bin/demo 04
```

You can also run `ruby demos/04-streaming/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one streamed chat request to your default chat model.

## What to look at

The `chunks:` line fills in one chunk at a time. Offline, each chunk is one word of the haiku, and the stub pauses briefly between words. The cost line prints after the stream ends.

Docs: https://rubyllm.com/streaming/

Guided lesson: `guided/lessons/04-streaming.md`
