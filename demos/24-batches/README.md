# 24. Batches of chats

This demo stages three `ask_later` chats that classify help-desk lines and prints each staged message. It calls `RubyLLM.batch` only when `GLASS_BOX_MODE=live` and `GLASS_BOX_BATCH=1` are both set. It names `chat.approve` next to `question.approve` so a learner can tell the two pauses apart.

## Run

```
GLASS_BOX_MODE=offline bin/demo 24
```

You can also run `ruby demos/24-batches/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run submits nothing unless you also set `GLASS_BOX_BATCH=1`. With that flag, the demo submits one batch of three chats to your default provider, and the results arrive later.

## What to look at

Each `staged` line shows a chat whose last message has the role user and has gone to no provider. The final lines say whether the demo called `RubyLLM.batch`.

Docs: https://rubyllm.com/batches/

Guided lesson: `guided/lessons/24-batches.md`
