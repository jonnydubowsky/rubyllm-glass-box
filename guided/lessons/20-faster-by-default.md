# 20. Faster by default in RubyLLM 2.1

The tour's card lists four measurements that compare RubyLLM 2.1 with 2.0. Streaming 500 Anthropic deltas takes 4.1 ms, and streaming a 2 MB event takes 2.0 ms. A streamed chat of 40 turns keeps 0.48 MB in memory, and eight threads load the model registry in 32 ms.

This step prints that card and the installed gem version. It runs no benchmark and makes no claim that 2.2.3 matches those timings. The RubyLLM docs page is the source for the numbers.

The brand composite is a local sum, so scoring a company never waits on a round trip to a model. The workshop uses this card to make that point. The published timings are a separate matter.

## Run

```
bin/learn run 20
ruby demos/20-faster-by-default/run.rb
```

Docs: https://rubyllm.com/whats-new-in-2-1/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
