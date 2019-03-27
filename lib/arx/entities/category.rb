require 'arx/categories'
require 'arx/cleaner'

module Arx

  # Entity/model representing an arXiv paper's category.
  class Category
    include HappyMapper

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
  end
end