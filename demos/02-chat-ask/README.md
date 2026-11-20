# 02. chat.ask starts a conversation

This demo creates a chat with `RubyLLM.chat` and sends the tour's unicorn prompt with one `chat.ask` call. It prints the transcript and `chat.cost.total`. Offline, `RubyLLM::TestHelper::Script` supplies both the reply and the cost.

## Run

```
GLASS_BOX_MODE=offline bin/demo 02
```

You can also run `ruby demos/02-chat-ask/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/chat/

Guided lesson: `guided/lessons/02-chat-ask.md`
