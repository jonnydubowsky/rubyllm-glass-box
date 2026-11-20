# 15. Nineteen providers, one Ruby API

This demo prints the tour's three constructor lines and the list of provider slugs in this gem. The tour counts 19 providers, and this release has 23. Offline, the stub lets the script create chats on Anthropic, Gemini and Bedrock and send each one a line. In live mode, the demo skips any provider whose key is not set. Bedrock also needs `BEDROCK_API_KEY`, `BEDROCK_SECRET_KEY` and `BEDROCK_REGION`.

## Run

```
GLASS_BOX_MODE=offline bin/demo 15
```

You can also run `ruby demos/15-providers-one-api/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one chat request to each of Anthropic, Gemini and Bedrock that has a key, and skips the others.

## What to look at

Count the slugs under `[providers in ruby_llm 2.2.3]`. Each block after that prints `chat.model.id` and the provider before the reply. On Bedrock, the gem resolves `claude-sonnet-5` to `anthropic.claude-sonnet-5`, the id that Bedrock uses.

Docs: https://rubyllm.com/models/

Guided lesson: `guided/lessons/15-providers-one-api.md`
