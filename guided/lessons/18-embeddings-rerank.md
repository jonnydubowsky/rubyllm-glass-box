# 18. Embeddings and reranking

`RubyLLM.embed` returns vectors. One string uses `#vectors` as a flat list and `#vector` as the same list. Several strings keep one vector per string on `#vectors`. The demo prints that distinction with the tour's sentence.

This step embeds each fictional blurb. Offline, the vector has length 8 and `model=offline-fixture`. It is derived from the text bytes. It is not a model embedding. The log says `RubyLLM.embed` was not called.

Rerank orders the help articles for "How do I reset my password?". Offline scores are keyword overlap. Live rerank runs for Cohere `rerank-v3.5` when `COHERE_API_KEY` is set, or for `RUBYLLM_RERANK_MODEL` and `RUBYLLM_RERANK_PROVIDER` when you set both. A chat key alone does not rerank.

## Run

```
bin/learn run 18
ruby demos/18-embeddings-rerank/run.rb
```

Docs: https://rubyllm.com/embeddings/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
