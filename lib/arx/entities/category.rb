module Arx

  # Entity/model representing an arXiv paper's category.
  class Category
    include HappyMapper
    include Inspector

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

    inspector :name, :full_name
  end
end