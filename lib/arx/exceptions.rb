module Arx

  # Custom error for missing links on an arXiv paper.
  class MissingLinkError < StandardError
    def initialize(link_type)
      super "This arXiv paper does not have a #{link_type} link"
    end
  end

  # Custom error for missing fields on an arXiv paper.
  class MissingFieldError < StandardError
    def initialize(field)
      super "This arXiv paper is missing the `#{field}` field"
    end
  end

  # Custom error for missing arXiv papers.
  class MissingPaper < StandardError
    def initialize(id)
      super "Couldn't find an arXiv paper with ID: #{id}"
    end
  end
end