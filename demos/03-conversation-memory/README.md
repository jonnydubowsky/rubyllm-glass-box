# 03. The same chat remembers the last turn

This demo calls `ask` twice on the same chat. The second prompt says only "Tell me another." The script prints the role of every message, so you can see that the chat object keeps the earlier turns.

## Run

```
GLASS_BOX_MODE=offline bin/demo 03
```

You can also run `ruby demos/03-conversation-memory/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends two chat requests on one chat. The second request carries the first turn.

## What to look at

The transcript has four messages. The second user message says only "Tell me another.", and the reply is another bedtime story, so the second request must have carried the first turn. The `roles:` line lists the same four messages by role. The cost line is the total for both asks.

Docs: https://rubyllm.com/chat/

Guided lesson: `guided/lessons/03-conversation-memory.md`
