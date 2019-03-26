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
    # @note The +sort_by+ and +sort_order+ arguments are ignored if passing in your own +query+.
    # @param ids [Array<String>] The IDs of the arXiv papers to restrict the query to.
    # @param query [Query, NilClass] Predefined search query object.
    # @param sort_by [Symbol] The sorting criteria for the returned results (see {Query::SORT_BY}).
    # @param sort_order [Symbol] The sorting order for the returned results (see {Query::SORT_ORDER}).
    # @return [Array<Paper>, Paper] The {Paper}(s) found by the search query.
    def search(*ids, query: nil, sort_by: :relevance, sort_order: :descending)
      if query.nil?
        yield query = Query.new(*ids, sort_by: sort_by, sort_order: sort_order) if block_given?
      else
        raise TypeError.new("Expected `query` to be an Arx::Query, got: #{query.class}") unless query.is_a? Query
      end

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
# @note The +sort_by+ and +sort_order+ arguments are ignored if passing in your own +query+.
# @see Arx.search
# @param ids [Array<String>] The IDs of the arXiv papers to restrict the query to.
# @param query [Query, NilClass] Predefined search query object.
# @param sort_by [Symbol] The sorting criteria for the returned results (see {Arx::Query::SORT_BY}).
# @param sort_order [Symbol] The sorting order for the returned results (see {Arx::Query::SORT_ORDER}).
# @return [Array<Paper>, Paper] The {Arx::Paper}(s) found by the search query.
def Arx(*ids, query: nil, sort_by: :relevance, sort_order: :descending, &block)
  Arx.search *ids, query: query, sort_by: sort_by, sort_order: sort_order, &block
end