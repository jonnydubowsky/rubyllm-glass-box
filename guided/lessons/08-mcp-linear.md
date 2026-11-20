# 08. An MCP server declared as a Ruby class

The tour declares a Linear server as a subclass of `RubyLLM::MCP`: a URL, an `inputs` owner, OAuth, an `only` list, `requires_approval` on the write, and the apps extension. Those class methods match the current gem. This course declares that class and does not open `https://mcp.linear.app/mcp`.

The runnable server is `GlassBox::CatalogMCP`. Its transport answers the MCP handshake in process and lists fictional titles. `list_titles` for Lantern Reel returns The Last Lantern, the platform Lantern, and 48 episodes. `create_note` is marked `requires_approval` and is not called in this step.

Look at `only` on the declared class, then the local tool list and the `list_titles` text.

## Run

```
bin/learn run 8
ruby demos/08-mcp-linear/run.rb
```

Docs: https://rubyllm.com/mcp/

The standalone demo is the tour's example. The guided step uses the fictional catalog and the local score when the concept can carry a brand question. Weights, bands, and company rows are in `lib/glass_box/sbpi.rb` and `guided/data/catalog.yml`.
