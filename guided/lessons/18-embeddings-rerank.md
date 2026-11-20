# 18. Embeddings and reranking

`RubyLLM.embed` returns vectors. For one string, `#vectors` is a flat list, and `#vector` returns the same list. For several strings, `#vectors` holds one vector per string. The demo shows the difference with the tour's sentence.

This step embeds each fictional company's blurb. Offline, each vector has 8 numbers and `model=offline-fixture`. The step derives the numbers from the text's bytes, so they are not a model's embedding, and the log says the step didn't call `RubyLLM.embed`.

The rerank call orders the help articles for the question "How do I reset my password?". Offline, each score measures keyword overlap. Live reranking runs on Cohere `rerank-v3.5` when `COHERE_API_KEY` is set, or on `RUBYLLM_RERANK_MODEL` and `RUBYLLM_RERANK_PROVIDER` when you set both. A chat key alone doesn't turn on reranking.

## Run

```
bin/learn run 18
ruby demos/18-embeddings-rerank/run.rb
```

Docs: https://rubyllm.com/embeddings/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
