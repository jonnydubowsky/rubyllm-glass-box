# 27. Use Ruby

The tour ends on the install line and a link to rubyllm.com. The card has no demo directory. `demos/27-closing` prints the install line, the gem version this course pins, the site, and the tour file.

The guided step also prints the five fictional companies and the two category examples, ReelShort and DramaBox. Those names are examples of the micro-drama category. They are not catalog rows and they have no scores here.

The composites you saw in earlier steps are weighted sums in `lib/glass_box/sbpi.rb`. The model narrated them. The tools fetched catalog rows. The evaluation checked the band strings. The traces listed the calls.

## Run

```
bin/learn run 27
ruby demos/27-closing/run.rb
```

Docs: https://rubyllm.com/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
