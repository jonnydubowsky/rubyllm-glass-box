# 15. Nineteen providers, one Ruby API

Prints the three constructor lines from the tour and the provider slugs in this gem. The tour says 19. This release has 23. Offline, the stub lets the script construct OpenAI, Anthropic, Gemini, and Bedrock chats and ask each one line. Live, a provider is skipped unless its key is set. Bedrock also needs `BEDROCK_API_KEY`, `BEDROCK_SECRET_KEY`, and `BEDROCK_REGION`.

## Run

```
ruby demos/15-providers-one-api/run.rb
```

Or `bin/demo 15`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/models/

Guided lesson: `guided/lessons/15-providers-one-api.md`
