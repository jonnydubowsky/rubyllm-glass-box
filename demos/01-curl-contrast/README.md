# 01. A raw provider request next to RubyLLM

This demo prints the tour's curl command without sending it. It then reads the saved provider response in `demos/fixtures/openai_response.json`, finds the output item of type message, and prints its text. Finally, it sends the tour's unicorn prompt through `chat.ask`. Offline, the reply is the sentence stored in the fixture. In live mode, `chat.ask` calls the provider.

## Run

```
GLASS_BOX_MODE=offline bin/demo 01
```

You can also run `ruby demos/01-curl-contrast/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/getting-started/

Guided lesson: `guided/lessons/01-curl-contrast.md`
