# 04. Streaming tokens with a block

`ask` with a block. Each `chunk.content` is printed as it arrives. Offline, the test helper splits the stubbed haiku on words. That is the chunk stream the gem produces under the stub, not a provider delta feed.

## Run

```
ruby demos/04-streaming/run.rb
```

Or `bin/demo 04`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/streaming/

Guided lesson: `guided/lessons/04-streaming.md`
