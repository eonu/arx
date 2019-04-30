module Arx

  # Entity/model representing an arXiv paper's category.
  class Category
    include HappyMapper
    include Inspector

    # The attributes of an arXiv paper category.
    ATTRIBUTES = %i[name full_name]

    tag 'category'

    # @!method name
    # The abbreviated name of the category.
    # @return [String]
    attribute :name, Cleaner, parser: :clean, tag: 'term'

    # The full name of the category.
    # @see CATEGORIES
    # @return [String]
    def full_name
      CATEGORIES[name]
    end

    # Serializes the {Category} object into a +Hash+.
    # @return [Hash]
    def to_h
      Hash[*ATTRIBUTES.map {|_| [_, send(_)]}.flatten(1)]
    end

    inspector *ATTRIBUTES
  end
end