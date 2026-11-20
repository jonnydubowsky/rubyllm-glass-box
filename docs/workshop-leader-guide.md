# Workshop leader guide

This guide is for a person who leads a workshop from this repository. It covers setup on a Mac, the time each part takes, the places where a run can stop, and the demos that spend money in live mode.

The measurements come from one MacBook with an Apple chip, macOS 27.2 and Ruby 3.4.2. The same checks passed on Ruby 4.0.9.

## Set up the leader's Mac a day ahead

The course needs Ruby 3.2.3 or newer. The Ruby that ships with macOS is 2.6.10, at `/usr/bin/ruby`, and it is too old. Install a newer Ruby with Homebrew or rbenv before you run anything else.

```
brew install ruby
```

Homebrew prints the `PATH` line to add to your shell profile. Open a new terminal window after you add it, and then check the version.

```
ruby -v
```

Clone the repository and run the setup script.

```
git clone https://github.com/jonnydubowsky/rubyllm-glass-box
cd rubyllm-glass-box
bin/setup
```

`bin/setup` stops with a message if Ruby is missing or older than 3.2.3. Otherwise it runs `bundle install` and copies `.env.example` to `.env`. On the test MacBook, `bundle install` took 5 seconds with the gems already downloaded. A first install also downloads the gems, so allow more time on a slow connection.

Then run the three checks.

```
GLASS_BOX_MODE=offline bin/demo all
GLASS_BOX_MODE=offline bin/learn auto
bundle exec rake test
```

All three need no network and no key. `bin/demo all` prints 27 demo headers and exits 0. `bin/learn auto` ends with `Checkpoint 27 saved.` The test run ends with `0 failures, 0 errors`. Run `bin/learn reset` afterwards so that your own course starts at step 1.

## Choose offline or live before the session

Offline mode needs no keys and costs nothing. Every chat reply comes from a script, and the calls that the test helper can't script use labeled stand-ins. Set the mode once in `.env`, so nobody has to type it.

```
GLASS_BOX_MODE=offline
```

If you leave `GLASS_BOX_MODE` blank, each program checks for a chat key. With a key it runs live, and with no key it runs offline. A key that a learner's shell profile exports counts, even when `.env` is blank. A learner with an old `OPENAI_API_KEY` export can therefore run live without meaning to. Every demo and every guided step prints a `mode:` line near the top. Ask learners to read that line on their first run.

For a live session, each learner adds one chat key to `.env`. One key from OpenAI, Anthropic, Gemini, xAI or OpenRouter runs the chat steps. The other keys in `.env.example` turn on single calls, such as reranking on Cohere or OCR on Mistral. A call with no key uses its stand-in and says so.

## Check live mode with your own keys

`bin/live-check` runs every demo against real providers and prints one row per demo. Each row shows the exit status, how many requests reached a provider, how many calls used a stand-in, and the cost the demo printed or the first error.

```
bin/live-check
bin/live-check 11 16
```

The script spends money on the accounts whose keys are set. It leaves image generation, video generation and batch submission off unless you set `GLASS_BOX_PAID_MEDIA=1` or `GLASS_BOX_BATCH=1` yourself. It saves each demo's full output under `tmp/live-check`.

## How long each part takes

The course outline groups the 27 steps into nine parts. Offline, the programs take almost no time. `bin/learn auto` ran all 27 steps in 2 seconds on the test MacBook, `bin/demo all` took 16 seconds, one demo took under a second, and the test suite took 40 seconds. Learners spend the session reading and discussing.

Nobody has timed this course with a group yet, so the minutes column is a starting plan and holds no measurement. It allows 5 minutes for each step, which covers reading the lesson, running the step and comparing the output with the lesson. Time your first session and replace the column with your own numbers.

| Part | Steps | Lesson words | Starting plan |
| --- | --- | --- | --- |
| 1. A Ruby API for chat | 1 to 3 | 624 | 15 minutes |
| 2. Streaming and Rails | 4 and 5 | 364 | 10 minutes |
| 3. Files, tools, and MCP | 6 to 9 | 871 | 20 minutes |
| 4. Structure, judgment, and evaluation | 10 to 12 | 622 | 15 minutes |
| 5. Agents, approval, and traces | 13 and 14 | 428 | 10 minutes |
| 6. One API, many providers | 15 | 211 | 5 minutes |
| 7. Speech, images, and retrieval | 16 to 19 | 739 | 20 minutes |
| 8. Production controls | 20 to 26 | 1303 | 35 minutes |
| 9. Workshop close | 27 | 176 | 5 minutes |

The plan adds up to 135 minutes without setup, the tour video or breaks. The tour video runs 3 minutes. Part 8 has the most steps and the most reading, so it is the first candidate to split across two sittings.

## Where a run can stop

These are the stops found while testing the repository on a Mac. Each one has a fix that a learner can apply alone.

| What the learner sees | Cause | Fix |
| --- | --- | --- |
| `bin/setup` says the course needs Ruby 3.2.3 or newer | The shell runs the Ruby that ships with macOS | Install Ruby with Homebrew or rbenv, open a new terminal window and run `bin/setup` again |
| `mode: live provider` when the learner expected offline | The learner's shell profile exports a chat key | Set `GLASS_BOX_MODE=offline` in `.env` |
| `The provider call failed.` with `UnauthorizedError` | The provider rejected the key | Replace the key in `.env`, or set `GLASS_BOX_MODE=offline` |
| `The provider call failed.` with `ConfigurationError` | The step needs a provider that has no key | Add that key, or set `GLASS_BOX_MODE=offline` |
| `bin/learn` prints a lesson and then waits | The program waits for Enter before it runs a step | Press Enter |
| Step 14 prints `Checkpoint 14 was not saved.` | The learner declined the approval, or typed something other than `yes` | Run `bin/learn 14` again and type `yes` |
| Demo 9 or demo 14 declines without asking | The program has no terminal to read from, as in a pipe | Run it in a terminal, or set `GLASS_BOX_APPROVE=yes` |
| Step 21 says Anthropic is not configured | A live run of the fallback step needs an Anthropic key | Run that step with `GLASS_BOX_MODE=offline` |
| `bin/learn` says every checkpoint is saved | The learner finished, or ran `bin/learn auto` | Run `bin/learn reset` |
| A long Ruby backtrace after a provider error | `RUBYLLM_DEBUG=true` is set | Unset it to get the short report |

A learner who declines the approval in step 9 still gets a checkpoint, because that step teaches both answers. Step 14 saves its checkpoint only after an approval.

## Which demos spend money in live mode

Offline, nothing in this repository calls a provider. In live mode, each row below sends the requests it lists, and the provider bills them at its own prices. The guided steps send the same kinds of requests as the demos with the same numbers.

| Demo | Requests in live mode | Key it needs |
| --- | --- | --- |
| 01 to 05 | One or two chat requests each | Any chat key |
| 06 | Two chat requests with attached files | Any chat key, on a model that accepts images and PDF files |
| 07 | Chat requests until the model has answered | Any chat key |
| 08 | None | None |
| 09 | Chat requests until the turn ends | Gemini, or any chat key |
| 10 | One chat request with a schema | Any chat key |
| 11 | One judgment request | TypeSafe, OpenAI or Gemini |
| 12 | None | None |
| 13 | Chat requests until the model has answered | Any chat key |
| 14 | Chat requests until the turn ends | Anthropic, or any chat key |
| 15 | One chat request per configured provider | Anthropic, Gemini, Bedrock |
| 16 | One speech request and one transcription request | OpenAI, or ElevenLabs for speech |
| 17 | None by default. With `GLASS_BOX_PAID_MEDIA=1`, one image request and one video request | OpenAI for the image, xAI for the video |
| 18 | One embedding request and one rerank request | OpenAI for the embedding, Cohere for the rerank |
| 19 | One OCR request and one moderation request | Mistral for OCR, OpenAI for moderation |
| 20 | None | None |
| 21 | One chat request, and a second on the fallback model if the first fails | Anthropic |
| 22 | One chat request with thinking and web search | Any chat key |
| 23 | One chat request with an attached file and citations | Any chat key |
| 24 | None by default. With `GLASS_BOX_BATCH=1`, one batch of three chats | Any chat key |
| 25 | Chat requests until the model has answered | Any chat key |
| 26 | One token-count request | Any chat key |
| 27 | None | None |

Image and video generation charge as soon as the request runs, and a video render takes time. Keep `GLASS_BOX_PAID_MEDIA` unset on shared keys.
