module Arx

  # Entity/model representing an arXiv paper's author.
  class Author
    include HappyMapper
    include Inspector

    # The attributes of an arXiv paper's author.
    ATTRIBUTES = %i[name affiliated? affiliations]

    tag 'author'

    # @!method name
    # The name of the author.
    #
    # @return [String]
    element :name, Cleaner, tag: 'name', parser: :clean

    # @!method affiliations
    # The author's affiliations.
    #
    # @return [Array<String>]
    has_many :affiliations, Cleaner, tag: 'affiliation', parser: :clean

    # Whether or not the author has any affiliations.
    #
    # @return [Boolean]
    def affiliated?
      !affiliations.empty?
    end

    # Serializes the {Author} object into a +Hash+.
    #
    # @return [Hash]
    def to_h
      Hash[*ATTRIBUTES.map {|_| [_, send(_)]}.flatten(1)]
    end

    # Serializes the {Author} object into a valid JSON hash.
    #
    # @return [Hash] The resulting JSON hash.
    def as_json
      JSON.parse to_json
    end

    # Serializes the {Author} object into a valid JSON string.
    #
    # @return [String] The resulting JSON string.
    def to_json
      to_h.to_json
    end

    inspector *ATTRIBUTES
  end
end