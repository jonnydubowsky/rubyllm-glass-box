# 22. Extended thinking and provider web search

This demo sets `with_thinking(effort: :high)` and `with_provider_tools(:web_search)`, prints both settings and asks one question. If the gem raises `UnsupportedServerToolError` because the model has no web search, the demo prints the error class and keeps going. The stub returns no citations. After the reply, the demo prints a recorded citation and labels it as an example from outside this response.

## Run

```
GLASS_BOX_MODE=offline bin/demo 22
```

You can also run `ruby demos/22-thinking-and-provider-tools/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one chat request with high thinking effort and web search to your default chat model.

## What to look at

`[thinking]` and `[provider tools]` print the settings on the chat before the request. After the reply, `[response.thinking]` is nil offline, and `[citations]` reports an empty list. The last two lines are the tour's recorded citation, which this run did not produce.

Docs: https://rubyllm.com/thinking/

Guided lesson: `guided/lessons/22-thinking-and-provider-tools.md`
