# 22. Extended thinking and provider web search

This demo sets `with_thinking(effort: :high)` and `with_provider_tools(:web_search)`, prints both settings and asks one question. If the model rejects the server tool, the demo prints the error class and keeps going. The stub returns no citations. After the reply, the demo prints a recorded citation and labels it as an example from outside this response.

## Run

```
GLASS_BOX_MODE=offline bin/demo 22
```

You can also run `ruby demos/22-thinking-and-provider-tools/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/thinking/

Guided lesson: `guided/lessons/22-thinking-and-provider-tools.md`
