# Guided track

One catalog, twenty-seven steps, in tour order. The companies are fictional. The five dimension names, the weights, and the band names are the public Structural Brand Power Index labels used in this workshop. The composite is a weighted sum in `lib/glass_box/sbpi.rb`. The model narrates and fills structured output. Tools read the catalog. Evaluations check the band strings. Traces print the calls.

ReelShort and DramaBox appear only as names of the category. They are not rows and they have no scores.

## Run

```
bin/learn
bin/learn status
bin/learn 4
bin/learn auto
bin/learn reset
```

`bin/learn` runs the next unfinished step and writes `tmp/learn/progress.json`. Step 14 waits until you type yes, because it publishes a score card. `bin/learn auto` sets `GLASS_BOX_APPROVE=yes` and runs every step.

Lessons are in `guided/lessons`. The dataset for the score evaluation is `guided/evals/brand_score.yml`. The catalog is `guided/data/catalog.yml`.

`GLASS_BOX_MODE=offline` (also `mock` or `fixture`) stubs chat and uses local stand-ins for embed, rerank, speech, images, OCR, moderation, and judgments. With the mode unset, a configured provider is called for the operations that have a key. Paint, video, and batch submit stay off until `GLASS_BOX_PAID_MEDIA=1` or `GLASS_BOX_BATCH=1`.
