# 19. OCR and moderation

`RubyLLM.ocr` reads a document into markdown. `RubyLLM.moderate` returns `flagged?` and a cost, and the cost may be nil. A nil cost is different from a cost of zero.

The document is `demos/fixtures/terms.pdf`, a one-page agreement written for this course. Offline, the markdown comes from `demos/fixtures/terms.md`, and the log says the step didn't call OCR. Live OCR uses Mistral's `mistral-ocr-latest` when `MISTRAL_API_KEY` is set.

The moderation sample is a mild sentence about Stall Seven. Offline, `flagged?` is false from a local check. Live moderation uses OpenAI. Neither call scores a brand.

## Run

```
bin/learn run 19
ruby demos/19-ocr-moderation/run.rb
```

Docs: https://rubyllm.com/ocr/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
