# 03. The same chat remembers the last turn

This demo calls `ask` twice on the same chat. The second prompt says only "Tell me another." The script prints the role of every message, so you can see that the chat object keeps the earlier turns.

## Run

```
GLASS_BOX_MODE=offline bin/demo 03
```

You can also run `ruby demos/03-conversation-memory/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/chat/

Guided lesson: `guided/lessons/03-conversation-memory.md`
