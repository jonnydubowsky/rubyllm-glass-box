# 16. Speech and transcription

## The concept

`RubyLLM.speak` turns text into audio and returns an object you can save to a file. `RubyLLM.transcribe` reads an audio file and returns its text as `transcription.text`.

## What this step does

The step speaks this sentence, saves the audio and transcribes the file: "Night Bazaar composite is 85.9, Category Dominant." The composite and the band come from the scorer.

Offline, `speak` writes a silent WAV file to `tmp/learn/speech.wav`, and the log says so. `transcribe` returns the source sentence without reading the file. Live speech uses OpenAI, or ElevenLabs when ElevenLabs is the configured speech path and OpenAI is absent. Live transcription uses OpenAI.

## What to look at

Read the two `[fixture]` or `[provider]` lines to learn which calls reached a provider. Then read `strings match`. Offline, a match shows only that the fixture echoed the source sentence, and it says nothing about the audio. In live mode, compare the transcript with the source sentence yourself, because a provider may write the number in words.

## Run

```
bin/learn 16
GLASS_BOX_MODE=offline bin/demo 16
```

`bin/learn 16` prints this lesson and then runs the step. `bin/demo 16` runs the standalone demo in `demos/16-speech-transcription`.

Docs: https://rubyllm.com/text-to-speech/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
