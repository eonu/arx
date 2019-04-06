# frozen_string_literal: true

module Arx

  # Class for generating arXiv search API query strings.
  #
  # @attr query [String] The string representing the search query.
  class Query

    # Mapping for URL query parameters supported by the arXiv search API.
    PARAMS = {
      search_query: 'search_query',
      id_list: 'id_list',
      sort_by: 'sortBy',
      sort_order: 'sortOrder'
    }

    # Logical connectives supported by the arXiv search API.
    CONNECTIVES = {
      and: 'AND',
      or: 'OR',
      and_not: 'ANDNOT'
    }

    # Supported fields for the search queries made to the arXiv search API.
    # @see https://arxiv.org/help/prep arXiv metadata fields
    # @see https://arxiv.org/help/api/user-manual#query_details arXiv user manual (query details)
    FIELDS = {
      title: 'ti',     # Title
      author: 'au',    # Author
      abstract: 'abs', # Abstract
      comment: 'co',   # Comment
      journal: 'jr',   # Journal reference
      category: 'cat', # Subject category
      report: 'rn',    # Report number
      all: 'all'       # All (of the above)
    }

    # Supported criteria for the +sortBy+ parameter.
    SORT_BY = {
      relevance: 'relevance',
      last_updated: 'lastUpdated',
      date_submitted: 'submittedDate'
    }

    # Supported criteria for the +sortOrder+ parameter.
    SORT_ORDER = {
      ascending: 'ascending',
      descending: 'descending'
    }

    # Initializes a new Query object.
    #
    # @param ids [Array<String>] The IDs of the arXiv papers to restrict the query to.
    # @param sort_by [Symbol] The sorting criteria for the returned results (see {SORT_BY}).
    # @param sort_order [Symbol] The sorting order for the returned results (see {SORT_ORDER}).
    # @return [Query] The initialized query object.
    def initialize(*ids, sort_by: :relevance, sort_order: :descending)
      @query = String.new

      Validate.sort_by sort_by, permitted: SORT_BY.keys
      @query << "#{PARAMS[:sort_by]}=#{SORT_BY[sort_by]}"

      Validate.sort_order sort_order, permitted: SORT_ORDER.keys
      @query << "&#{PARAMS[:sort_order]}=#{SORT_ORDER[sort_order]}"

      ids.flatten!
      unless ids.empty?
        ids.map! &Cleaner.method(:extract_id)
        @query << "&#{PARAMS[:id_list]}=#{ids * ','}"
      end

      yield self if block_given?
    end

    # @!method and
    # Logical conjunction (+AND+) of subqueries.
    # @see https://arxiv.org/help/api/user-manual#query_details arXiv user manual
    # @return [self]

    # @!method and_not
    # Logical negated conjunction (+ANDNOT+) of subqueries.
    # @see https://arxiv.org/help/api/user-manual#query_details arXiv user manual
    # @return [self]

    # @!method or
    # Logical disjunction (+OR+) of subqueries.
    # @see https://arxiv.org/help/api/user-manual#query_details arXiv user manual
    # @return [self]

    CONNECTIVES.keys.each do |connective|
      define_method(connective) { add_connective connective }
    end

    # @!method title(*values, exact: true, connective: :and)
    # Search for papers by {https://arxiv.org/help/prep#title title}.
    # @param values [Array<String>] Title(s) of papers to search for.
    # @param exact [Boolean] Whether to search for an exact match of the title(s).
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    # @!method author(*values, exact: true, connective: :and)
    # Search for papers by {https://arxiv.org/help/prep#author author}.
    # @param values [Array<String>] Author(s) of papers to search for.
    # @param exact [Boolean] Whether to search for an exact match of the author's name(s).
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    # @!method abstract(*values, exact: true, connective: :and)
    # Search for papers by {https://arxiv.org/help/prep#abstract abstract}.
    # @param values [Array<String>] Abstract(s) of papers to search for.
    # @param exact [Boolean] Whether to search for an exact match of the abstract(s).
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    # @!method comment(*values, exact: true, connective: :and)
    # Search for papers by {https://arxiv.org/help/prep#comments comment}.
    # @param values [Array<String>] Comment(s) of papers to search for.
    # @param exact [Boolean] Whether to search for an exact match of the comment(s).
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    # @!method journal(*values, exact: true, connective: :and)
    # Search for papers by {https://arxiv.org/help/prep#journal journal reference}.
    # @param values [Array<String>] Journal reference(s) of papers to search for.
    # @param exact [Boolean] Whether to search for an exact match of the journal refernece(s).
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    # @!method category(*values, connective: :and)
    # Search for papers by {https://arxiv.org/help/prep#category category}.
    # @param values [Array<String>] Category(s) of papers to search for.
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    # @!method report(*values, connective: :and)
    # Search for papers by {https://arxiv.org/help/prep#report report number}.
    # @param values [Array<String>] Report number(s) of papers to search for.
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    # @!method all(*values, exact: true, connective: :and)
    # Search for papers by all fields (see {FIELDS}).
    # @param values [Array<String>] Field value(s) of papers to search for.
    # @param exact [Boolean] Whether to search for an exact match of the comment(s).
    # @param connective [Symbol] The logical connective to use (see {CONNECTIVES}). Only applies if there are multiple values.
    # @return [self]

    FIELDS.each do |name, field|
      define_method(name) do |*values, exact: true, connective: :and|
        return if values.empty?

        values.flatten!

        Validate.values values
        Validate.categories values if name == :category
        Validate.exact exact
        Validate.connective connective, permitted: CONNECTIVES.keys

        values.map! &CGI.method(:escape)

        # Forms a field:value pair
        pair = ->(value){"#{field}:#{exact ? enquote(value) : value}"}

        subquery = if values.size > 1
          parenthesize values.map(&pair).join("+#{CONNECTIVES[connective]}+")
        else
          pair.(values.first)
        end

        add_subquery subquery
        self
      end
    end

    # Returns the query string.
    #
    # @return [String]
    def to_s
      @query
    end

    private

    # Appends a logical connective to the end of the query string.
    #
    # @see CONNECTIVES
    # @param connective [Symbol] The symbol of the logical connective to add.
    # @return [self]
    def add_connective(connective)
      return unless search_query?
      @query << "+#{CONNECTIVES[connective]}" unless ends_with_connective?
      self
    end

    # Appends a subquery to the end of the query string.
    #
    # @param subquery [String] The subquery to add.
    def add_subquery(subquery)
      if search_query?
        if ends_with_connective?
          @query << "+#{subquery}"
        else
          add_connective :and
          @query << "+#{subquery}"
        end
      else
        @query << "&#{PARAMS[:search_query]}=#{subquery}"
      end
    end

    # Whether the query string contains the +search_query+ parameter.
    #
    # @see PARAMS
    # @return [Boolean]
    def search_query?
      @query.include? PARAMS[:search_query]
    end

    # Whether the query string ends in a logical connective.
    #
    # @see CONNECTIVES
    # @return [Boolean]
    def ends_with_connective?
      CONNECTIVES.values.any? &@query.method(:end_with?)
    end

    # Parenthesizes a string with CGI-escaped parentheses.
    #
    # @param string [String] The string to parenthesize.
    # @return [String] The parenthesized string.
    def parenthesize(string)
      CGI.escape('(') + string + CGI.escape(')')
    end

    # Enquotes a string with CGI-escaped double quotes.
    #
    # @param string [String] The string to enquote.
    # @return [String] The enquoted string.
    def enquote(string)
      CGI.escape("\"") + string + CGI.escape("\"")
    end
  end
end