# 05. Streaming a chat through a Rails job

This demo runs without booting Rails. It prints the tour's `ChatStreamJob` and then the `ChatResponseJob` that the 2.2.3 generator writes, which calls `chat.complete(&:broadcast)`. An in-memory object implements `broadcast_chunk` and collects each chunk string while a sentence streams. The tour's job calls `broadcast_append_chunk`. Releases 1.14 through 2.1 of the generator wrote that method into the app's message model, and the 2.2.3 gem defines no method by that name for a chat to call.

## Run

```
GLASS_BOX_MODE=offline bin/demo 05
```

You can also run `ruby demos/05-rails-turbo-stream/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one streamed chat request to your default chat model.

## What to look at

Compare the two job classes. The tour's job handles each chunk in a block of its own, and the current job passes `&:broadcast`. Then count the `broadcast_chunk` lines, one per chunk, and check that `[page text]` joins them into the full sentence.

Docs: https://rubyllm.com/rails-streaming/

Guided lesson: `guided/lessons/05-rails-turbo-stream.md`
