# 16. Speech and transcription

This demo turns "Welcome to the show!" into speech, saves the audio and transcribes the file. Offline, the file is `speech.wav` and holds silence, and the transcript is the source sentence copied back. The log says the demo called neither provider. In live mode, speech uses OpenAI or ElevenLabs, and transcription uses OpenAI. The demo names the saved file after the format the provider returns, which is mp3 by default.

## Run

```
GLASS_BOX_MODE=offline bin/demo 16
```

You can also run `ruby demos/16-speech-transcription/run.rb` directly. With `GLASS_BOX_MODE=offline`, the demo uses the test stub and the files in `demos/fixtures`. If you leave the mode unset and you have set a chat key, the demo runs live.

## What a live run sends

A live run sends one speech request to OpenAI or ElevenLabs and one transcription request to OpenAI.

## What to look at

The two `[fixture]` or `[provider]` lines say which calls reached a provider. `[file]` gives the path, the size and the MIME type. Offline, the file is 3244 bytes of silence. `round trip strings match` compares the transcript with the source sentence, and offline it shows only that the fixture echoed the sentence.

Docs: https://rubyllm.com/text-to-speech/

Guided lesson: `guided/lessons/16-speech-transcription.md`
