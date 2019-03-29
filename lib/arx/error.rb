module Arx

  # Various arXiv-related errors.
  module Error

    # Custom error for missing links on an arXiv paper.
    class MissingLink < StandardError
      def initialize(id, link_type)
        super "arXiv paper #{id} does not have a #{link_type} link"
      end
    end

    # Custom error for missing fields on an arXiv paper.
    class MissingField < StandardError
      def initialize(id, field)
        super "arXiv paper #{id} is missing the `#{field}` metadata field"
      end
    end

    # Custom error for missing arXiv papers.
    class MissingPaper < StandardError
      def initialize(id)
        super "Couldn't find an arXiv paper with ID: #{id}"
      end
    end
  end
end