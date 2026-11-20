# frozen_string_literal: true

require "ruby_llm"

module GlassBox
  # An in-process MCP transport. It speaks the legacy initialize handshake
  # RubyLLM falls back to when server/discover is missing, then answers
  # tools/list and tools/call from the fictional catalog.
  class CatalogTransport
    def initialize(catalog = Catalog.load, store: nil)
      @catalog = catalog
      @store = store || []
    end

    attr_reader :store

    def request(message, version:, timeout: nil, headers: {})
      method = fetch(message, :method)
      id = fetch(message, :id)
      params = fetch(message, :params) || {}
      result = case method
               when "server/discover"
                 return rpc_error(id, -32_601, "Method not found")
               when "initialize"
                 {
                   "protocolVersion" => "2025-11-25",
                   "capabilities" => { "tools" => {} },
                   "serverInfo" => { "name" => "catalog", "version" => "0.0.1" }
                 }
               when "ping"
                 {}
               when "tools/list"
                 { "tools" => tool_definitions }
               when "tools/call"
                 call_tool(params)
               else
                 return rpc_error(id, -32_601, "Method not found: #{method}")
               end
      { "jsonrpc" => "2.0", "id" => id, "result" => result }
    end

    def notify(message, version:)
      nil
    end

    def cancel(notification, version:)
      nil
    end

    def close
      nil
    end

    def tool_definitions
      [
        {
          "name" => "list_titles",
          "description" => "List fictional micro-drama titles and public catalog fields",
          "inputSchema" => {
            "type" => "object",
            "properties" => {
              "company" => { "type" => "string", "description" => "Fictional company name" }
            },
            "additionalProperties" => false
          },
          "annotations" => { "readOnlyHint" => true, "destructiveHint" => false }
        },
        {
          "name" => "create_note",
          "description" => "Record a catalog note on a fictional title",
          "inputSchema" => {
            "type" => "object",
            "properties" => {
              "title" => { "type" => "string" },
              "note" => { "type" => "string" }
            },
            "required" => %w[title note],
            "additionalProperties" => false
          },
          "annotations" => { "readOnlyHint" => false, "destructiveHint" => false }
        }
      ]
    end

    def call_tool(params)
      name = fetch(params, :name)
      arguments = fetch(params, :arguments) || {}
      text = case name
             when "list_titles"
               company_name = fetch(arguments, :company)
               company = company_name ? @catalog.find_company(company_name) : nil
               rows = company ? [company] : @catalog.companies
               rows.flat_map { |row| row.titles.map { |title| "#{title.name} | #{row.platform} | #{title.episodes} episodes" } }.join("\n")
             when "create_note"
               entry = { "title" => fetch(arguments, :title), "note" => fetch(arguments, :note) }
               @store << entry
               "recorded #{entry["title"]}"
             else
               return { "isError" => true, "content" => [{ "type" => "text", "text" => "unknown tool #{name}" }] }
             end
      { "content" => [{ "type" => "text", "text" => text }], "isError" => false }
    end

    def fetch(hash, key)
      return nil unless hash.respond_to?(:[])

      hash[key] || hash[key.to_s]
    end

    def rpc_error(id, code, message)
      { "jsonrpc" => "2.0", "id" => id, "error" => { "code" => code, "message" => message } }
    end
  end

  class CatalogMCP < ::RubyLLM::MCP
    inputs :catalog
    transport { CatalogTransport.new(catalog) }
    only :list_titles, :create_note
    requires_approval :create_note
  end
end
