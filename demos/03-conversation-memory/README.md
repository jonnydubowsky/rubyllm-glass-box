# 03. The same chat remembers the last turn

Two `ask` calls on one chat. The second prompt is only "Tell me another." The script prints every message role so you can see the history that stays on the object.

## Run

```
ruby demos/03-conversation-memory/run.rb
```

Or `bin/demo 03`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/chat/

Guided lesson: `guided/lessons/03-conversation-memory.md`
