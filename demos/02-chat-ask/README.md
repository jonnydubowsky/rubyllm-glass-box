# 02. chat.ask starts a conversation

This demo creates a chat with `RubyLLM.chat` and sends the tour's unicorn prompt with one `chat.ask` call. It prints the transcript and `chat.cost.total`. Offline, `RubyLLM::TestHelper::Script` supplies both the reply and the cost.

## Run

```
GLASS_BOX_MODE=offline bin/demo 02
```

You can also run `ruby demos/02-chat-ask/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one chat request to your default chat model.

## What to look at

`[prompt]` and `[reply]` are the two sides of one `chat.ask` call. `[transcript]` shows the same exchange as the chat object stores it, with one user message and one assistant message. The last line is `chat.cost.total`.

Docs: https://rubyllm.com/chat/

Guided lesson: `guided/lessons/02-chat-ask.md`
