module Arx

  # Entity/model representing an arXiv paper's category.
  class Category
    include HappyMapper
    include Inspector

    # The attributes of an arXiv paper's category.
    ATTRIBUTES = %i[name full_name]

    tag 'category'

    # @!method name
    # The abbreviated name of the category.
    #
    # @return [String]
    attribute :name, Cleaner, parser: :clean, tag: 'term'

    # The full name of the category.
    #
    # @see CATEGORIES
    # @return [String]
    def full_name
      CATEGORIES[name]
    end

    # Serializes the {Category} object into a +Hash+.
    #
    # @return [Hash]
    def to_h
      Hash[*ATTRIBUTES.map {|_| [_, send(_)]}.flatten(1)]
    end

    # Serializes the {Category} object into a valid JSON hash.
    #
    # @return [Hash] The resulting JSON hash.
    def as_json
      JSON.parse to_json
    end

    # Serializes the {Category} object into a valid JSON string.
    #
    # @return [String] The resulting JSON string.
    def to_json
      to_h.to_json
    end

    # Equality check against another category.
    #
    # @param category [Category] The category to compare against.
    def ==(category)
      if category.is_a? Category
        name == category.name
      else
        false
      end
    end

    inspector *ATTRIBUTES
  end
end