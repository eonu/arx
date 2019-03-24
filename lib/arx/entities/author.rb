require 'happymapper'
require 'arx/cleaner'

module Arx

  # Entity/model representing an arXiv paper's author.
  class Author
    include HappyMapper

    tag 'author'

    # @!method name
    # The name of the author.
    # @return [String]
    element :name, Cleaner, tag: 'name', parser: :clean

    # @!method affiliations
    # The author's affiliations.
    # @return [Array<String>]
    has_many :affiliations, Cleaner, tag: 'affiliation', parser: :clean

    # @!method affiliations?
    # Whether or not the author has any affiliations.
    # @return [Boolean]
    def affiliations?
      !affiliations.empty?
    end
  end
end