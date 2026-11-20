# 27. Use Ruby

The tour ends on the install line and a link to rubyllm.com, and that card has no demo directory. `demos/27-closing` prints the install line, the gem version this course pins, the site and the tour video's address.

The guided step also prints the five fictional companies and the two category examples, ReelShort and DramaBox. Those two names are examples of the micro-drama category. Neither one is a row in the catalog, and neither has a score.

Every composite score in the earlier steps is a weighted sum in `lib/glass_box/sbpi.rb`. In those steps, the model described the scores, the tools fetched catalog rows, the evaluation checked the band names, and the traces listed the calls.

## Run

```
bin/learn run 27
ruby demos/27-closing/run.rb
```

Docs: https://rubyllm.com/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
