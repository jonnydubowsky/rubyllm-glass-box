# 04. Streaming tokens with a block

This demo passes a block to `ask` and prints each `chunk.content` as it arrives. Offline, the test helper splits the scripted haiku into words. Those words are the chunks the gem produces under the stub. A live provider sends its own deltas.

## Run

```
GLASS_BOX_MODE=offline bin/demo 04
```

You can also run `ruby demos/04-streaming/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/streaming/

Guided lesson: `guided/lessons/04-streaming.md`
