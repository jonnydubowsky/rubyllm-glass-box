# RubyLLM glass box

Runnable demos of every concept in the [RubyLLM tour](https://github.com/crmne/ruby_llm/releases/download/v2.1.0/rubyllm-tour.mp4), plus a guided path that scores a fictional micro-drama catalog in the open.

RubyLLM is the library by Carmine Paolino: [rubyllm.com](https://rubyllm.com/) and [github.com/crmne/ruby_llm](https://github.com/crmne/ruby_llm). This repository pins `ruby_llm` 2.2.3. Where the tour's on-screen code and the current gem differ, the demos call the current API and the demo README says what changed.

A glass box here means you can read the prompt, the tool call, the decision, the cost, and the trace in the terminal. The number on a brand card is computed in Ruby. The model does not get to be the only place that number exists.

## Run

Ruby 3.2.3 or newer. On a Mac, rbenv or mise will pick up `.ruby-version`.

```
bin/setup
GLASS_BOX_MODE=offline bin/demo 02
GLASS_BOX_MODE=offline bin/demo all
bin/learn
bin/learn auto
bundle exec rake test
```

`bin/setup` runs `bundle install` and copies `.env.example` to `.env` when you do not already have one. Keys can stay blank.

`GLASS_BOX_MODE=offline` (or `mock`, or `fixture`) runs every demo and the guided path with no network. Chat uses RubyLLM's test helper, so the tool loop, approval pause, schema parse, streaming, fallbacks, and cost object are the real gem, fed by a scripted reply. Embeddings, rerank, speech, images, video, OCR, moderation, judgments, and token counts use a labeled local stand-in, because those methods are not covered by the chat stub.

Leave the mode unset, or set `GLASS_BOX_MODE=live`, and a call goes to a provider when its key is set. Paint and video also need `GLASS_BOX_PAID_MEDIA=1`. Paint uses OpenAI unless `RUBYLLM_IMAGE_MODEL` is set. Video needs `XAI_API_KEY`. `RubyLLM.batch` also needs `GLASS_BOX_BATCH=1`. Approval prompts read stdin. `GLASS_BOX_APPROVE=yes` approves when there is no terminal, which is what `bin/learn auto` sets.

Keys read from the environment or `.env`: `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GEMINI_API_KEY` or `GOOGLE_API_KEY`, `OPENROUTER_API_KEY`, `XAI_API_KEY`. Optional: `COHERE_API_KEY`, `MISTRAL_API_KEY`, `TYPESAFE_API_KEY`, `ELEVENLABS_API_KEY`, and the `RUBYLLM_*` overrides in `.env.example`.

## The catalog

Five fictional companies live in `guided/data/catalog.yml`. Dimension inputs are numbers this course assigns. The composite is the weighted sum:

| Dimension | Weight |
| --- | --- |
| Content Strength | 0.20 |
| Narrative Ownership | 0.20 |
| Distribution Power | 0.25 |
| Community Strength | 0.20 |
| Monetization Infrastructure | 0.15 |

Bands: Category Dominant from 85, Strong Ecosystem Player from 70, Emerging Power from 55, Niche Player from 40, Limited Structural Presence below 40.

ReelShort and DramaBox are named only as examples of the micro-drama category. They are not scored.

## Concepts

| | Tour concept | Demo | Lesson |
| --- | --- | --- | --- |
| 01 | A raw provider request next to RubyLLM | `demos/01-curl-contrast` | `guided/lessons/01-curl-contrast.md` |
| 02 | chat.ask starts a conversation | `demos/02-chat-ask` | `guided/lessons/02-chat-ask.md` |
| 03 | The same chat remembers the last turn | `demos/03-conversation-memory` | `guided/lessons/03-conversation-memory.md` |
| 04 | Streaming tokens with a block | `demos/04-streaming` | `guided/lessons/04-streaming.md` |
| 05 | Streaming a chat through a Rails job | `demos/05-rails-turbo-stream` | `guided/lessons/05-rails-turbo-stream.md` |
| 06 | Attachments | `demos/06-attachments` | `guided/lessons/06-attachments.md` |
| 07 | A Ruby tool the model can call | `demos/07-tools-weather` | `guided/lessons/07-tools-weather.md` |
| 08 | An MCP server declared as a Ruby class | `demos/08-mcp-linear` | `guided/lessons/08-mcp-linear.md` |
| 09 | Tool search and an MCP App approval | `demos/09-tool-search` | `guided/lessons/09-tool-search.md` |
| 10 | Structured output with a Schematist schema | `demos/10-structured-output` | `guided/lessons/10-structured-output.md` |
| 11 | Typed judgments | `demos/11-judgments` | `guided/lessons/11-judgments.md` |
| 12 | Evaluating an agent against a dataset | `demos/12-evaluations` | `guided/lessons/12-evaluations.md` |
| 13 | Tracing a run with OpenTelemetry | `demos/13-opentelemetry` | `guided/lessons/13-opentelemetry.md` |
| 14 | An agent, approval, and a workflow | `demos/14-agents-approval-workflows` | `guided/lessons/14-agents-approval-workflows.md` |
| 15 | Nineteen providers, one Ruby API | `demos/15-providers-one-api` | `guided/lessons/15-providers-one-api.md` |
| 16 | Speech and transcription | `demos/16-speech-transcription` | `guided/lessons/16-speech-transcription.md` |
| 17 | Image and video generation | `demos/17-image-video-generation` | `guided/lessons/17-image-video-generation.md` |
| 18 | Embeddings and reranking | `demos/18-embeddings-rerank` | `guided/lessons/18-embeddings-rerank.md` |
| 19 | OCR and moderation | `demos/19-ocr-moderation` | `guided/lessons/19-ocr-moderation.md` |
| 20 | Faster by default in RubyLLM 2.1 | `demos/20-faster-by-default` | `guided/lessons/20-faster-by-default.md` |
| 21 | Model fallbacks and prompt caching | `demos/21-fallbacks-and-caching` | `guided/lessons/21-fallbacks-and-caching.md` |
| 22 | Extended thinking and provider web search | `demos/22-thinking-and-provider-tools` | `guided/lessons/22-thinking-and-provider-tools.md` |
| 23 | Citations and cost tracking | `demos/23-citations-and-cost` | `guided/lessons/23-citations-and-cost.md` |
| 24 | Batches of chats | `demos/24-batches` | `guided/lessons/24-batches.md` |
| 25 | Compaction and the agentic loop | `demos/25-compaction-and-agentic-loop` | `guided/lessons/25-compaction-and-agentic-loop.md` |
| 26 | The model registry and token counting | `demos/26-model-registry-and-tokens` | `guided/lessons/26-model-registry-and-tokens.md` |
| 27 | Use Ruby | `demos/27-closing` | `guided/lessons/27-closing.md` |

The tour's closing card has no demo directory. `demos/27-closing` is the install line and the links.

## What stays a stand-in

These are visible in the output, and the demo READMEs repeat them.

* Rails streaming is an in-memory stand-in. The current generator job is `ChatResponseJob` with `chat.complete(&:broadcast)`. The tour showed `broadcast_append_chunk`.
* The Linear server is declared and not connected. A local catalog MCP server answers `list_titles`.
* Evaluations set `evaluator false`. A model does not grade the answers. The tour demo's sale-item case fails on purpose.
* Judgments, OCR, rerank, speech, images, video, token counts, batch submit, and web-search citations hit the network only with the key and flag named above. Offline speech writes a silent WAV. The tour's "5 tokens" and a cache hit are not invented when the provider did not return them.
* `clef-flash` on Ollama is mentioned and not called. It is not in the bundled registry.

## Tests

`bundle exec rake test` is offline. GitHub Actions runs it on the newest Ruby 3.2 available to the runner. The suite checks the score boundaries, the catalog, that every demo exits 0, and that `bin/learn auto` finishes.
