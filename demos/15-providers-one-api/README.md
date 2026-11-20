# 15. Nineteen providers, one Ruby API

This demo prints the tour's three constructor lines and the list of provider slugs in this gem. The tour counts 19 providers, and this release has 23. Offline, the stub lets the script create OpenAI, Anthropic, Gemini and Bedrock chats and send each one a line. In live mode, the demo skips any provider whose key is not set. Bedrock also needs `BEDROCK_API_KEY`, `BEDROCK_SECRET_KEY` and `BEDROCK_REGION`.

## Run

```
GLASS_BOX_MODE=offline bin/demo 15
```

You can also run `ruby demos/15-providers-one-api/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/models/

Guided lesson: `guided/lessons/15-providers-one-api.md`
