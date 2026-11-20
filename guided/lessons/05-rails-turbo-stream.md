# 05. Streaming a chat through a Rails job

The tour loads a saved Chat inside an Active Job and appends each chunk to the page. The job on screen is `ChatStreamJob`, and it calls `message.broadcast_append_chunk`.

In ruby_llm 2.2.3, the chat UI generator writes `ChatResponseJob`, which calls `chat.complete(&:broadcast)`. `Chunk#broadcast` ends in a call to `message.broadcast_chunk`. `broadcast_append_chunk` came from older generated application code, and this gem has no method by that name.

The course runs this step without booting Rails. The step streams a sentence that includes Lantern Reel's composite score of 68.5 and counts the chunks that an in-memory page would have appended. `GlassBox::SBPI` computes that score before the model writes anything.

Read the two job classes that `demos/05-rails-turbo-stream/run.rb` prints, and then read the chunk count in this step.

## Run

```
bin/learn run 5
ruby demos/05-rails-turbo-stream/run.rb
```

Docs: https://rubyllm.com/rails-streaming/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
