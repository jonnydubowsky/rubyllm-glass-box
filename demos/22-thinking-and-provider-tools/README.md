# 22. Extended thinking and provider web search

Sets `with_thinking(effort: :high)` and `with_provider_tools(:web_search)`, prints both settings, and asks one question. If the model rejects the server tool, the error class is printed and the script continues. Citations from the stub are empty. A recorded citation is printed below and labeled as not from this response.

## Run

```
ruby demos/22-thinking-and-provider-tools/run.rb
```

Or `bin/demo 22`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/thinking/

Guided lesson: `guided/lessons/22-thinking-and-provider-tools.md`
