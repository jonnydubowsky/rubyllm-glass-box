# 19. OCR and moderation

This demo runs OCR on `demos/fixtures/terms.pdf` and moderation on a short, harmless string. Offline, OCR returns the markdown stored next to the PDF, and moderation returns `flagged?` as false. Live OCR needs `MISTRAL_API_KEY`, and live moderation needs OpenAI. The demo prints the cost only when it has a value.

## Run

```
GLASS_BOX_MODE=offline bin/demo 19
```

You can also run `ruby demos/19-ocr-moderation/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one OCR request to Mistral and one moderation request to OpenAI. Each call falls back to its fixture when its key is missing.

## What to look at

`[markdown]` is the document's text. Offline, the demo reads that text from `demos/fixtures/terms.md`, and the `[fixture]` line says so. `flagged?` is false for the sample string. The cost line prints nil when the provider reported no price.

Docs: https://rubyllm.com/ocr/

Guided lesson: `guided/lessons/19-ocr-moderation.md`
