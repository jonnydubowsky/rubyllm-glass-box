# 19. OCR and moderation

This demo runs OCR on `demos/fixtures/terms.pdf` and moderation on a short, harmless string. Offline, OCR returns the markdown stored next to the PDF, and moderation returns `flagged?` as false. Live OCR needs `MISTRAL_API_KEY`, and live moderation needs OpenAI. The demo prints the cost only when it has a value.

## Run

```
GLASS_BOX_MODE=offline bin/demo 19
```

You can also run `ruby demos/19-ocr-moderation/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset, the demo sends its live calls to the provider you have configured, and its other calls still use the fixtures.

## What to look at

The script first prints the mode and the gem version. It then prints the parts of the call that this concept covers, such as the request, the tool calls, the transcript, the cost or the trace. Read those lines first, and then read the model's reply.

Docs: https://rubyllm.com/ocr/

Guided lesson: `guided/lessons/19-ocr-moderation.md`
