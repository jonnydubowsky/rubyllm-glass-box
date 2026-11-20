# 24. Batches of chats

Three `ask_later` chats, classified as help-desk lines. Prints each staged message. Does not call `RubyLLM.batch` unless `GLASS_BOX_MODE=live` and `GLASS_BOX_BATCH=1`. Mentions `chat.approve` beside `question.approve` so the two pauses are not mixed up.

## Run

```
ruby demos/24-batches/run.rb
```

Or `bin/demo 24`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/batches/

Guided lesson: `guided/lessons/24-batches.md`
