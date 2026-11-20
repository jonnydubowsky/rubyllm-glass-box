# Guided track

The guided track runs 27 steps in the same order as the tour, and every step uses one catalog of fictional companies. The five dimension names, the weights and the band names are the public Structural Brand Power Index labels that this workshop uses. Ruby code in `lib/glass_box/sbpi.rb` computes each composite score as a weighted sum. Across the steps, the model describes the scores and fills in structured output, the tools read the catalog, the evaluations check the band names, and the traces print the calls.

ReelShort and DramaBox appear only as names of the category. Neither one is a row in the catalog, and neither has a score.

## Run

```
bin/learn
bin/learn status
bin/learn 4
bin/learn auto
bin/learn reset
```

`bin/learn` runs the next unfinished step and records progress in `tmp/learn/progress.json`. Step 14 publishes a score card, so it waits until you type yes. `bin/learn auto` sets `GLASS_BOX_APPROVE=yes` and runs every step.

The lessons are in `guided/lessons`. The dataset for the score evaluation is `guided/evals/brand_score.yml`, and the catalog is `guided/data/catalog.yml`.

With `GLASS_BOX_MODE=offline` (or `mock` or `fixture`), the track stubs chat and uses local stand-ins for embedding, reranking, speech, images, OCR, moderation and judgments. If you leave the mode unset, the track calls a configured provider for each operation that has a key. Image generation, video generation and batch submission stay off until you set `GLASS_BOX_PAID_MEDIA=1` or `GLASS_BOX_BATCH=1`.
