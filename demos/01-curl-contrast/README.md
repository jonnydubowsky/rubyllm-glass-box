# 01. A raw provider request next to RubyLLM

Prints a curl command and does not send it. Parses `demos/fixtures/openai_response.json`, finds the output item with type message, and prints that text. Then `chat.ask` runs the unicorn prompt from the tour. Offline, the reply is the fixture sentence. Live, `chat.ask` calls the provider.

## Run

```
ruby demos/01-curl-contrast/run.rb
```

Or `bin/demo 01`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/getting-started/

Guided lesson: `guided/lessons/01-curl-contrast.md`
