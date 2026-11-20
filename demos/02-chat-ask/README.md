# 02. chat.ask starts a conversation

`RubyLLM.chat` and one `chat.ask`. The prompt is the tour's unicorn sentence. The transcript and `chat.cost.total` are printed. Offline, both the reply and the cost come from `RubyLLM::TestHelper::Script`.

## Run

```
ruby demos/02-chat-ask/run.rb
```

Or `bin/demo 02`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/chat/

Guided lesson: `guided/lessons/02-chat-ask.md`
