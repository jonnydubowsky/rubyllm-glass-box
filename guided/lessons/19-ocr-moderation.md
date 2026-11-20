# 19. OCR and moderation

`RubyLLM.ocr` reads a document into markdown. `RubyLLM.moderate` returns `flagged?` and a cost that may be nil. Nil is not zero.

The file is `demos/fixtures/terms.pdf`, a one-page agreement this course wrote. Offline, the markdown is the text in `demos/fixtures/terms.md`, and the log says OCR was not called. Live OCR uses Mistral and `mistral-ocr-latest` when `MISTRAL_API_KEY` is set.

The moderation sample is a mild sentence about Stall Seven. Offline, `flagged?` is a local false. Live moderation uses OpenAI. Neither call scores a brand.

## Run

```
bin/learn run 19
ruby demos/19-ocr-moderation/run.rb
```

Docs: https://rubyllm.com/ocr/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
