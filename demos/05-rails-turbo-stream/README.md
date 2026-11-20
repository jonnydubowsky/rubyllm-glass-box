# 05. Streaming a chat through a Rails job

This demo runs without booting Rails. It prints the tour's `ChatStreamJob` and then the `ChatResponseJob` that the 2.2.3 generator writes, which calls `chat.complete(&:broadcast)`. An in-memory object implements `broadcast_chunk` and collects each chunk string while a sentence streams. The tour's job calls `broadcast_append_chunk`, which an older version of the generator wrote. This gem has no method by that name.

## Run

```
GLASS_BOX_MODE=offline bin/demo 05
```

You can also run `ruby demos/05-rails-turbo-stream/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/rails-streaming/

Guided lesson: `guided/lessons/05-rails-turbo-stream.md`
