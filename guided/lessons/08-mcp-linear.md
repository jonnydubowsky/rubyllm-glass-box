# 08. An MCP server declared as a Ruby class

The tour declares a Linear server as a subclass of `RubyLLM::MCP`. The class sets a URL, an `inputs` owner, OAuth, an `only` list, `requires_approval` on the write tool and the apps extension. The current gem has the same class methods. This course declares the class and never opens `https://mcp.linear.app/mcp`.

The server that runs is `GlassBox::CatalogMCP`. Its transport answers the MCP handshake inside the same process and lists fictional titles. When the step calls `list_titles` for Lantern Reel, the server returns The Last Lantern on the platform Lantern, with 48 episodes. The `create_note` tool is marked `requires_approval`, and this step never calls it.

Read the `only` list on the declared class, and then read the local tool list and the `list_titles` result.

## Run

```
bin/learn run 8
ruby demos/08-mcp-linear/run.rb
```

Docs: https://rubyllm.com/mcp/

The standalone demo runs the tour's own example. The guided step asks about a fictional brand wherever the concept allows it, and local Ruby code scores that brand. The weights and bands are in `lib/glass_box/sbpi.rb`, and the company rows are in `guided/data/catalog.yml`.
