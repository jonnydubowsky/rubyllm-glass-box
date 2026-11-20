# 01. A raw provider request next to RubyLLM

This demo prints the tour's curl command without sending it. It then reads the saved provider response in `demos/fixtures/openai_response.json`, finds the output item of type message, and prints its text. Finally, it sends the tour's unicorn prompt through `chat.ask`. Offline, the reply is the sentence stored in the fixture. In live mode, `chat.ask` calls the provider.

## Run

```
GLASS_BOX_MODE=offline bin/demo 01
```

You can also run `ruby demos/01-curl-contrast/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one chat request to your default chat model. The demo never sends the curl.

## What to look at

Read `[curl (not sent)]`, and then `[assistant text from the fixture body]`. The script found that text by searching the `output` array for the item of type `message`. Open `demos/fixtures/openai_response.json` and find the same item by hand. The first item in that array is a reasoning item. Then read `[RubyLLM reply]`, which `chat.ask` returned as `response.content`.

Docs: https://rubyllm.com/getting-started/

Guided lesson: `guided/lessons/01-curl-contrast.md`
