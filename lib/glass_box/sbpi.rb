# frozen_string_literal: true

module GlassBox
  # Structural Brand Power Index, public dimension names only.
  # The composite is the weighted sum of five workshop-assigned inputs.
  module SBPI
    DIMENSIONS = [
      { key: "content_strength", label: "Content Strength", weight: 0.20 },
      { key: "narrative_ownership", label: "Narrative Ownership", weight: 0.20 },
      { key: "distribution_power", label: "Distribution Power", weight: 0.25 },
      { key: "community_strength", label: "Community Strength", weight: 0.20 },
      { key: "monetization_infrastructure", label: "Monetization Infrastructure", weight: 0.15 }
    ].freeze

    BANDS = [
      { name: "Category Dominant", min: 85 },
      { name: "Strong Ecosystem Player", min: 70 },
      { name: "Emerging Power", min: 55 },
      { name: "Niche Player", min: 40 },
      { name: "Limited Structural Presence", min: 0 }
    ].freeze

    module_function

    def dimension(key)
      DIMENSIONS.find { |dimension| dimension[:key] == key.to_s } or
        raise ArgumentError, "unknown dimension #{key}"
    end

    def composite(scores)
      DIMENSIONS.sum do |dimension|
        value = scores.fetch(dimension[:key]).to_f
        raise ArgumentError, "#{dimension[:key]} must be between 0 and 100" unless value.between?(0, 100)

        value * dimension[:weight]
      end.round(2)
    end

    def band(composite)
      BANDS.find { |entry| composite >= entry[:min] }[:name]
    end

    def explain(scores)
      lines = DIMENSIONS.map do |dimension|
        value = scores.fetch(dimension[:key]).to_f
        format("%-32s %6.1f  x %4.2f  = %6.2f", dimension[:label], value, dimension[:weight], value * dimension[:weight])
      end
      total = composite(scores)
      lines << format("%-32s %s", "Composite", total)
      lines << "Band: #{band(total)}"
      lines.join("\n")
    end
  end
end
