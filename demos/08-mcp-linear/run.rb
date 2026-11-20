#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/glass_box"

GlassBox.boot!
GlassBox.banner "08  An MCP server declared as a Ruby class"

# The tour's Linear server. Declared with the current DSL and not connected.
# requires_approval gates create_issue. only limits the tools the model sees.
class Linear < RubyLLM::MCP
  url "https://mcp.linear.app/mcp"
  inputs :user
  oauth owner: :user
  only :list_issues, :get_issue, :create_issue
  requires_approval :create_issue
  extension :apps
end

GlassBox.log "Linear.only", Linear.only.inspect
GlassBox.log "Linear approvals", Linear.approvals.inspect
GlassBox.log "Linear extensions", Linear.extensions.keys.inspect
puts "with_mcp(Linear.new(user: current_user), defer: true) is the tour's attach call."
puts "This demo does not open https://mcp.linear.app/mcp."
puts

catalog = GlassBox::Catalog.load
server = GlassBox::CatalogMCP.new(catalog: catalog)
GlassBox.log "fixture server tools", server.tools.map { |tool| "#{tool.name} read_only=#{tool.read_only?}" }.join("\n")
listed = server.list_titles(company: "Lantern Reel")
GlassBox.log "list_titles result", listed.text
puts "create_note is declared with requires_approval. The next demo waits on that call."
server.close
