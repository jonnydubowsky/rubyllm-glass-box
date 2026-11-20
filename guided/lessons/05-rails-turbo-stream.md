# 05. Streaming a chat through a Rails job

## The concept

A Rails app streams a reply by running the chat in a background job. The job loads a saved Chat record and completes it, and each chunk goes to the page over a Turbo Stream. In ruby_llm 2.2.3, the chat UI generator writes `ChatResponseJob`, which calls `chat.complete(&:broadcast)`. `Chunk#broadcast` ends in a call to `message.broadcast_chunk`.

The tour shows an older shape. The job on screen is `ChatStreamJob`, and it calls `message.broadcast_append_chunk`. Releases 1.14 through 2.1 of the chat UI generator wrote that method into the app's message model. The 2.2.3 gem defines no method by that name for a chat to call.

## What this step does

The course runs this step without booting Rails. The step sends this prompt with a block and collects each chunk in an array, the way a page would append them: "Lantern Reel has a composite of 68.5 in the Emerging Power band. Say so in one sentence." `GlassBox::SBPI` computes that score before the model writes anything.

## What to look at

Read the count under `[chunks appended in memory]`. A Rails page would have received that many appends. Then run `bin/demo 5` and read the two job classes that the demo prints.

## Run

```
bin/learn 5
GLASS_BOX_MODE=offline bin/demo 5
```

`bin/learn 5` prints this lesson and then runs the step. `bin/demo 5` runs the standalone demo in `demos/05-rails-turbo-stream`.

Docs: https://rubyllm.com/rails-streaming/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
