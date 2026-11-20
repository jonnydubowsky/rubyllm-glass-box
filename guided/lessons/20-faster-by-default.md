# 20. Faster by default in RubyLLM 2.1

## The concept

RubyLLM 2.1 made streaming and registry loading faster than they were in 2.0, and calling code did not have to change. The tour's card lists four measurements that compare the two releases. Streaming 500 Anthropic text deltas takes 4.1 ms, and streaming a 2 MB event in 16 KB pieces takes 2.0 ms. A streamed chat of 40 turns keeps 0.48 MB in memory, and eight threads load the model registry in 32 ms. The RubyLLM docs page is the source for the numbers.

## What this step does

The step prints that card and the installed gem version. It runs no benchmark and makes no claim that 2.2.3 matches those timings. No prompt goes to a model.

## What to look at

Read the four rows and the installed version under them. The last line makes a separate point about this course. The brand composite is a local sum, so scoring a company never waits on a round trip to a model.

## Run

```
bin/learn 20
GLASS_BOX_MODE=offline bin/demo 20
```

`bin/learn 20` prints this lesson and then runs the step. `bin/demo 20` runs the standalone demo in `demos/20-faster-by-default`.

Docs: https://rubyllm.com/whats-new-in-2-1/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
