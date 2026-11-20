# 16. Speech and transcription

`RubyLLM.speak` returns audio, and `RubyLLM.transcribe` returns text. The step builds its sentence from Night Bazaar's composite of 85.9 and its band, Category Dominant, so every word about the score comes from the scorer.

Offline, `speak` writes a silent WAV file, and the log says so. `transcribe` returns the source sentence without reading the WAV file. The string match checks that the fixture echoed the source sentence. It does not check the file for speech.

Live speech uses OpenAI, or ElevenLabs when ElevenLabs is the configured speech path and OpenAI is absent. Live transcription uses OpenAI. The step saves the file as `tmp/learn/speech.wav`.

## Run

```
bin/learn run 16
ruby demos/16-speech-transcription/run.rb
```

Docs: https://rubyllm.com/text-to-speech/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
