# 24. Batches of chats

This demo stages three `ask_later` chats that classify help-desk lines and prints each staged message. It calls `RubyLLM.batch` only when `GLASS_BOX_MODE=live` and `GLASS_BOX_BATCH=1` are both set. It names `chat.approve` next to `question.approve` so a learner can tell the two pauses apart.

## Run

```
GLASS_BOX_MODE=offline bin/demo 24
```

You can also run `ruby demos/24-batches/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/batches/

Guided lesson: `guided/lessons/24-batches.md`
