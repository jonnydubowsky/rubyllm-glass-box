# 05. Streaming a chat through a Rails job

The tour loads a persisted Chat inside an Active Job and appends each chunk to the page. The on-screen job is `ChatStreamJob`, and it calls `message.broadcast_append_chunk`.

ruby_llm 2.2.3's chat UI generator writes `ChatResponseJob`, which calls `chat.complete(&:broadcast)`. `Chunk#broadcast` reaches `message.broadcast_chunk`. `broadcast_append_chunk` is older generated application code. It is not a method this gem provides.

This course does not boot Rails. The step streams a sentence that includes Lantern Reel's composite, 68.5, and counts the chunks an in-memory page would have appended. The number is computed by `GlassBox::SBPI` before the model speaks.

Look at the job shapes printed by `demos/05-rails-turbo-stream/run.rb`, then at the chunk count in this step.

## Run

```
bin/learn run 5
ruby demos/05-rails-turbo-stream/run.rb
```

Docs: https://rubyllm.com/rails-streaming/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
