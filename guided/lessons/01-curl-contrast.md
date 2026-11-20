# 01. A raw provider request next to RubyLLM

## The concept

A provider's HTTP API returns the assistant's text inside nested JSON. In OpenAI's Responses API, the sentence sits inside a content part of type `output_text`, and that part sits inside an output item of type `message`. The first output item is often a reasoning item, so code that reads `output[0]` can miss the sentence.

`RubyLLM.chat` and `chat.ask` send the same kind of request and return the reply's text as `response.content`. The tour opens on this contrast, with a curl call to the Responses API followed by two lines of Ruby.

## What this step does

The step builds a Responses API body in memory for one catalog question and never sends the curl. The first output item in that body is a reasoning item, and the second is the message. The step finds the message item and prints its text.

The step then sends the same question through `chat.ask`: "The catalog lists The Last Lantern under the company Lantern Reel. Which company publishes The Last Lantern?" The prompt names the publisher, so you can check the reply against the prompt. Offline, the test helper supplies the reply and the cost. With `GLASS_BOX_MODE=live` and a provider key, `chat.ask` calls the provider. The step still never sends the curl.

## What to look at

Read the `[curl (not sent)]` line first, and then the text that the step took from the message item. Under `[prompt]` and `[reply]`, check that the reply names Lantern Reel. The last line is `chat.cost.total`. Later in the course some costs are nil, and a nil cost is different from zero.

## Run

```
bin/learn 1
GLASS_BOX_MODE=offline bin/demo 1
```

`bin/learn 1` prints this lesson and then runs the step. `bin/demo 1` runs the standalone demo in `demos/01-curl-contrast`.

Docs: https://rubyllm.com/getting-started/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
