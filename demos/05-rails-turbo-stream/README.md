# 05. Streaming a chat through a Rails job

Does not boot Rails. Prints the tour's `ChatStreamJob` and the 2.2.3 generator's `ChatResponseJob` (`chat.complete(&:broadcast)`). An in-memory object implements `broadcast_chunk` and collects chunk strings while a sentence streams. `broadcast_append_chunk` is the tour's older generated call, not a method on this gem.

## Run

```
ruby demos/05-rails-turbo-stream/run.rb
```

Or `bin/demo 05`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/rails-streaming/

Guided lesson: `guided/lessons/05-rails-turbo-stream.md`
