# 16. Speech and transcription

`RubyLLM.speak` returns audio. `RubyLLM.transcribe` returns text. The sentence in this step is built from Night Bazaar's composite and band, 85.9 and Category Dominant, so the words you hear about are the scorer's words.

Offline, speak writes a silent WAV and the log says so. Transcribe returns the source sentence. It does not read the WAV. The string match is a check that the fixture echoed the source, not a check that the file contains speech.

Live speech uses OpenAI, or ElevenLabs when that is the configured speech path and OpenAI is absent. Live transcription uses OpenAI. The saved file is `tmp/learn/speech.wav`.

## Run

```
bin/learn run 16
ruby demos/16-speech-transcription/run.rb
```

Docs: https://rubyllm.com/text-to-speech/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
