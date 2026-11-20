# 16. Speech and transcription

Speaks "Welcome to the show!", saves a WAV, and transcribes it. Offline the WAV is silence and the transcript is the source string copied back. The log says both providers were not called. Live speech uses OpenAI or ElevenLabs. Live transcription uses OpenAI.

## Run

```
ruby demos/16-speech-transcription/run.rb
```

Or `bin/demo 16`. `GLASS_BOX_MODE=offline` forces the stub and the fixtures. With the variable unset, a configured provider is used for the calls that this demo marks as live, and the rest stay on fixtures.

## What to look at

The script prints a banner with the mode and the gem version, then the request, tool calls, transcript, cost, or trace that this concept is about. Read those lines before the model's sentence.

Docs: https://rubyllm.com/text-to-speech/

Guided lesson: `guided/lessons/16-speech-transcription.md`
