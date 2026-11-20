# 19. OCR and moderation

Runs OCR on `demos/fixtures/terms.pdf` and moderation on a short benign string. Offline OCR returns the markdown this course stored beside the PDF, and moderation returns `flagged?` false. Live OCR needs `MISTRAL_API_KEY`. Live moderation needs OpenAI. Cost is printed only when it is non-nil.

## Run

```
ruby demos/19-ocr-moderation/run.rb
```

Or `bin/demo 19`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/ocr/

Guided lesson: `guided/lessons/19-ocr-moderation.md`
