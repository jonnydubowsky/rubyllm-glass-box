# 27. Use Ruby

## The concept

RubyLLM installs as a gem with `bundle add ruby_llm`. The tour ends on that command and a link to rubyllm.com, and its closing card has no other code.

Every composite score in the earlier steps is a weighted sum in `lib/glass_box/sbpi.rb`. In those steps, the model described the scores, the tools fetched catalog rows, the evaluation checked the band names, and the traces listed the calls.

## What this step does

The step prints the install commands, the gem version this course pins, the site and the tour video's address. It also prints the five fictional companies and the two category examples, ReelShort and DramaBox. Those two names are examples of the micro-drama category. Neither one is a row in the catalog, and neither has a score. No prompt goes to a model in this step.

## What to look at

Check the version on the `bundle add` line against the `ruby_llm` line in the `Gemfile`. Then read the company list. `bin/learn status` shows every checkpoint you have saved.

## Run

```
bin/learn 27
GLASS_BOX_MODE=offline bin/demo 27
```

`bin/learn 27` prints this lesson and then runs the step. `bin/demo 27` runs the standalone demo in `demos/27-closing`.

Docs: https://rubyllm.com/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
