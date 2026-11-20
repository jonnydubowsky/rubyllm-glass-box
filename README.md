# RubyLLM glass box

This repository has a runnable demo for each of the 27 concepts in the [RubyLLM tour](https://github.com/crmne/ruby_llm/releases/download/v2.1.0/rubyllm-tour.mp4). It also has a guided course, `bin/learn`, in which the learner scores five fictional micro-drama companies.

Carmine Paolino wrote RubyLLM. Its site is [rubyllm.com](https://rubyllm.com/), and its source is at [github.com/crmne/ruby_llm](https://github.com/crmne/ruby_llm). This repository pins `ruby_llm` 2.2.3. In some places the current gem's API differs from the code in the tour. Those demos call the current API, and each one's README lists the difference.

The demos print the prompt, the tool call, the decision, the cost and the trace to the terminal, so a learner can read each one. Ruby code computes the score on each brand card, so the score exists outside the model's reply.

## Run

You need Ruby 3.2.3 or newer. On a Mac, rbenv or mise reads the version from `.ruby-version`.

```
bin/setup
GLASS_BOX_MODE=offline bin/demo 02
GLASS_BOX_MODE=offline bin/demo all
bin/learn
bin/learn auto
bundle exec rake test
```

`bin/setup` runs `bundle install` and copies `.env.example` to `.env` if you don't have a `.env` file yet. You can leave the keys blank.

With `GLASS_BOX_MODE=offline` (or `mock` or `fixture`), every demo and the guided course run without a network connection. In that mode the chat demos use RubyLLM's test helper, which feeds a scripted reply into the real gem. The real gem then handles the tool loop, the approval pause, the schema parse, streaming and fallbacks, and it builds the cost object. The test helper covers chat only, so the demos for embeddings, rerank, speech, images, video, OCR, moderation, judgments and token counts print labeled output from a local stand-in.

If you leave the mode unset or set `GLASS_BOX_MODE=live`, each demo calls a provider once that provider's key is set. `RubyLLM.paint` and video generation also need `GLASS_BOX_PAID_MEDIA=1`. The image demo uses OpenAI unless you set `RUBYLLM_IMAGE_MODEL`, and the video demo needs `XAI_API_KEY`. `RubyLLM.batch` also needs `GLASS_BOX_BATCH=1`.

The demos read approval answers from stdin. When no terminal is attached, `GLASS_BOX_APPROVE=yes` approves each request, and `bin/learn auto` sets that variable for you.

The demos read `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GEMINI_API_KEY` or `GOOGLE_API_KEY`, `OPENROUTER_API_KEY` and `XAI_API_KEY` from the environment or from `.env`. Some demos also read `COHERE_API_KEY`, `MISTRAL_API_KEY`, `TYPESAFE_API_KEY`, `ELEVENLABS_API_KEY` and the `RUBYLLM_*` overrides listed in `.env.example`.

## The catalog

The file `guided/data/catalog.yml` lists five fictional companies. Each company has an assigned number for each dimension below, and its composite score is the weighted sum of those numbers.

| Dimension | Weight |
| --- | --- |
| Content Strength | 0.20 |
| Narrative Ownership | 0.20 |
| Distribution Power | 0.25 |
| Community Strength | 0.20 |
| Monetization Infrastructure | 0.15 |

Each band covers a range of composite scores.

| Band | Composite score |
| --- | --- |
| Category Dominant | 85 and up |
| Strong Ecosystem Player | 70 to under 85 |
| Emerging Power | 55 to under 70 |
| Niche Player | 40 to under 55 |
| Limited Structural Presence | below 40 |

ReelShort and DramaBox appear only as examples of the micro-drama category. Neither one has a score.

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

The tour ends on a closing card with no code on it. `demos/27-closing` prints the install line and the links.

## Where the demos use stand-ins

Each demo labels its stand-in in the output, and the demo's README lists it again.

* The Rails streaming demo runs in memory without booting Rails. The current RubyLLM Rails generator writes a job named `ChatResponseJob` that calls `chat.complete(&:broadcast)`. The tour showed `broadcast_append_chunk`.
* The MCP demo declares the Linear server and leaves it unconnected. A local catalog MCP server answers `list_titles`.
* The evaluation demo sets `evaluator false`, so no model grades the answers. Its sale-item case fails on purpose.
* The demos for judgments, OCR, rerank, speech, images, video, token counts, batch submit and web-search citations call the network only when the key and flag named above are set. Offline, the speech demo writes a silent WAV file. The demos print the tour's "5 tokens" figure and a cache hit only when the provider returns them.
* `clef-flash` on Ollama is mentioned and never called, because the bundled registry doesn't include it.

## Tests

`bundle exec rake test` runs offline. GitHub Actions runs the same suite on the newest Ruby 3.2 the runner offers. The tests check the score boundaries and the catalog, and they confirm that every demo exits 0 and that `bin/learn auto` finishes.
