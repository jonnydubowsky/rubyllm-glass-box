# 19. OCR and moderation

## The concept

`RubyLLM.ocr` reads a document, such as a scanned PDF, and returns its text as markdown. `RubyLLM.moderate` checks a text against the provider's content policy and returns `flagged?`. A moderation result also carries a cost, and the cost may be nil. A nil cost is different from a cost of zero.

## What this step does

The document is `demos/fixtures/terms.pdf`, a one-page agreement written for this course. The step runs OCR on it and prints the first line of the markdown. Offline, the markdown comes from `demos/fixtures/terms.md`, and the log says the step didn't call OCR. Live OCR uses Mistral's `mistral-ocr-latest` when `MISTRAL_API_KEY` is set.

The step then moderates this comment: "The ending of Stall Seven was fair." Offline, `flagged?` is false from a local stand-in. Live moderation uses OpenAI. Neither call scores a brand.

## What to look at

Read the `[fixture]` or `[provider]` line above each result. The first line of the markdown should be the heading `# Service Agreement`, and `flagged?` should be false for the comment.

## Run

```
bin/learn 19
GLASS_BOX_MODE=offline bin/demo 19
```

`bin/learn 19` prints this lesson and then runs the step. `bin/demo 19` runs the standalone demo in `demos/19-ocr-moderation`.

Docs: https://rubyllm.com/ocr/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
