# 18. Embeddings and reranking

## The concept

`RubyLLM.embed` turns text into a vector, a list of numbers that a program can compare with the vectors of other texts. For one string, `#vectors` is a flat list, and `#vector` returns the same list. For several strings, `#vectors` holds one vector per string. `RubyLLM.rerank` takes a query and a list of documents and returns the documents in order of relevance, each with a score.

## What this step does

The step embeds the blurb of each fictional company's first title in one call and prints the length of each vector. It then reranks the catalog's help articles for the question "How do I reset my password?" and prints the top three.

Offline, each vector has 8 numbers that the step derives from the text's bytes, and each rerank score measures keyword overlap. Live embedding uses OpenAI. Live reranking runs on Cohere `rerank-v3.5` when `COHERE_API_KEY` is set, or on `RUBYLLM_RERANK_MODEL` and `RUBYLLM_RERANK_PROVIDER` when you set both. A chat key alone doesn't turn on reranking.

## What to look at

Each `[fixture]` or `[provider]` line says whether a model produced the numbers under it. Offline, `model=offline-fixture` marks a stand-in vector. In the rerank list, the two password articles should come first.

## Run

```
bin/learn 18
GLASS_BOX_MODE=offline bin/demo 18
```

`bin/learn 18` prints this lesson and then runs the step. `bin/demo 18` runs the standalone demo in `demos/18-embeddings-rerank`.

Docs: https://rubyllm.com/embeddings/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
