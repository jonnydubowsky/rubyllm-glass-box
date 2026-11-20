# 20. Faster by default in RubyLLM 2.1

The tour's card lists four measurements for RubyLLM 2.1 against 2.0: streaming 500 Anthropic deltas in 4.1 ms, a 2 MB event in 2.0 ms, 0.48 MB kept by a 40-turn streamed chat, and 32 ms to load the registry on eight threads.

This step prints that card and the installed gem version. It does not run a benchmark, and it does not claim those timings for 2.2.3. The docs page is the source.

The brand composite stays a local sum, so scoring a company does not wait on a model round trip. That is the workshop point of the card, separate from the published timings.

## Run

```
bin/learn run 20
ruby demos/20-faster-by-default/run.rb
```

Docs: https://rubyllm.com/whats-new-in-2-1/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
