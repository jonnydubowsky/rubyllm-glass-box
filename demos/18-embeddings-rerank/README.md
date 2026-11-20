# 18. Embeddings and reranking

This demo embeds one sentence and prints its `#vectors`. It then reranks the tour's five documents against a question about passwords. Offline, the vector is 8 floats derived from the text's bytes, and each rerank score measures keyword overlap. Live embedding needs OpenAI. Live reranking needs Cohere, or `RUBYLLM_RERANK_MODEL` and `RUBYLLM_RERANK_PROVIDER`.

## Run

```
GLASS_BOX_MODE=offline bin/demo 18
```

You can also run `ruby demos/18-embeddings-rerank/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one embedding request to OpenAI, and one rerank request to Cohere or to the model in `RUBYLLM_RERANK_MODEL`. Each call falls back to its fixture when its key is missing.

## What to look at

`[vectors]` prints the first 8 numbers, the vector's length and the model. Offline, the length is 8 and the model is `offline-fixture`. In the ranked list, the two password documents come first. Offline they tie at 0.33, because the stand-in counts shared words. The tour's card shows 0.98 and 0.91 from a rerank model.

Docs: https://rubyllm.com/embeddings/

Guided lesson: `guided/lessons/18-embeddings-rerank.md`
