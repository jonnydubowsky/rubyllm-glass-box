# frozen_string_literal: true

module GlassBox
  module Catalog
    PATH = ROOT.join("guided/data/catalog.yml")

    module_function

    def load
      raw = YAML.safe_load(PATH.read, aliases: false)
      companies = raw.fetch("companies").map { |row| Company.new(row) }
      articles = raw.fetch("help_articles")
      CatalogData.new(companies, articles, raw.fetch("category_examples").fetch("names"))
    end

    class Company
      attr_reader :name, :platform, :titles, :scores, :notes

      def initialize(row)
        @name = row.fetch("name")
        @platform = row.fetch("platform")
        @titles = row.fetch("titles").map { |title| Title.new(title) }
        @scores = row.fetch("dimension_inputs")
        @notes = row.fetch("notes")
      end

      def composite
        SBPI.composite(scores)
      end

      def band
        SBPI.band(composite)
      end

      def find_title(query)
        needle = query.to_s.downcase
        titles.find { |title| title.name.downcase.include?(needle) || needle.include?(title.name.downcase) }
      end
    end

    class Title
      attr_reader :name, :episodes, :logline, :blurb

      def initialize(row)
        @name = row.fetch("name")
        @episodes = row.fetch("episodes")
        @logline = row.fetch("logline")
        @blurb = row.fetch("blurb")
      end
    end

    CatalogData = Struct.new(:companies, :help_articles, :category_examples) do
      def find_company(name)
        needle = name.to_s.downcase
        companies.find { |company| company.name.downcase == needle || company.name.downcase.include?(needle) }
      end

      def find_title(name)
        companies.each do |company|
          title = company.find_title(name)
          return [company, title] if title
        end
        nil
      end
    end
  end
end
