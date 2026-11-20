# 18. Embeddings and reranking

Embeds one sentence and prints `#vectors`. Reranks the five tour documents for a password question. Offline vectors are 8 floats from the text bytes, and rerank scores are keyword overlap. Live embed and the related moderation path need OpenAI. Live rerank needs Cohere, or `RUBYLLM_RERANK_MODEL` plus `RUBYLLM_RERANK_PROVIDER`.

## Run

```
ruby demos/18-embeddings-rerank/run.rb
```

Or `bin/demo 18`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/embeddings/

Guided lesson: `guided/lessons/18-embeddings-rerank.md`
