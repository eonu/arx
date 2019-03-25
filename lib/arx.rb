# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'arx/version'
require 'arx/categories'
require 'arx/query/query'
require 'arx/query/validate'
require 'arx/entities/author'
require 'arx/entities/category'
require 'arx/entities/paper'

# A Ruby interface for querying academic papers on the arXiv search API.
module Arx

  # The arXiv search API endpoint.
  ENDPOINT = 'http://export.arxiv.org/api/query?'

  class << self

    # Performs a search query for papers on the arXiv search API.
    #
    # @param ids [Array<String>] The IDs of the arXiv papers to restrict the query to.
    # @param sort_by [Symbol] The sorting criteria for the returned results (see {Query::SORT_BY}).
    # @param sort_order [Symbol] The sorting order for the returned results (see {Query::SORT_ORDER}).
    # @return [Array<Paper>, Paper] The {Paper}(s) found by the search query.
    def search(*ids, sort_by: :relevance, sort_order: :descending)
      query = Query.new(*ids, sort_by: sort_by, sort_order: sort_order)

      yield query if block_given?

      document = Nokogiri::XML open(ENDPOINT + query.to_s + '&max_results=10000')
      document.remove_namespaces!

      results = Paper.parse(document, single: false).reject {|paper| paper.id.empty?}
      raise MissingPaper.new(ids.first) if results.empty? && ids.size == 1
      ids.size == 1 && results.size == 1 ? results.first : results
    end

    alias_method :find, :search
    alias_method :get, :search
  end
end

# Performs a search query for papers on the arXiv search API.
#
# @note This is an alias of the {Arx.search} method.
# @see Arx.search
# @param ids [Array<String>] The IDs of the arXiv papers to restrict the query to.
# @param sort_by [Symbol] The sorting criteria for the returned results (see {Arx::Query::SORT_BY}).
# @param sort_order [Symbol] The sorting order for the returned results (see {Arx::Query::SORT_ORDER}).
# @return [Array<Paper>, Paper] The {Arx::Paper}(s) found by the search query.
def Arx(*ids, sort_by: :relevance, sort_order: :descending, &block)
  if block_given?
    Arx.search *ids, sort_by: sort_by, sort_order: sort_order, &block
  else
    Arx.search *ids, sort_by: sort_by, sort_order: sort_order
  end
end