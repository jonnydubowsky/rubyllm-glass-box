# 18. Embeddings and reranking

This demo embeds one sentence and prints its `#vectors`. It then reranks the tour's five documents against a question about passwords. Offline, each vector is 8 floats derived from the text's bytes, and each rerank score measures keyword overlap. Live embedding, and the related moderation path, need OpenAI. Live reranking needs Cohere, or `RUBYLLM_RERANK_MODEL` and `RUBYLLM_RERANK_PROVIDER`.

## Run

```
GLASS_BOX_MODE=offline bin/demo 18
```

You can also run `ruby demos/18-embeddings-rerank/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/embeddings/

Guided lesson: `guided/lessons/18-embeddings-rerank.md`
