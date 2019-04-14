# frozen_string_literal: true

require 'cgi'
require 'nokogiri'
require 'open-uri'
require 'happymapper'
require 'arx/version'
require 'arx/cleaner'
require 'arx/inspector'
require 'arx/categories'
require 'arx/error'
require 'arx/query/validate'
require 'arx/query/query'
require 'arx/entities/author'
require 'arx/entities/category'
require 'arx/entities/link'
require 'arx/entities/paper'

# A Ruby interface for querying academic papers on the arXiv search API.
module Arx

  # The arXiv search API endpoint.
  ENDPOINT = 'http://export.arxiv.org/api/query?'

  # The current arxiv paper identifier scheme (1 April 2007 and onwards).
  #   The last block of digits can either be five digits (if the paper was published after 1501 - January 2015),
  #   or four digits (if the paper was published before 1501).
  #
  # @see https://arxiv.org/help/arxiv_identifier#new arXiv identifier (new)
  # @example
  #   1501.00001
  #   1705.01662v1
  #   1412.0135
  #   0706.0001v2
  NEW_IDENTIFIER_FORMAT = /^\d{4}\.\d{4,5}(v\d+)?$/

  # The legacy arXiv paper identifier scheme (before 1 April 2007).
  #
  # @see https://arxiv.org/help/arxiv_identifier#old arXiv identifier (old)
  # @example
  #   math/0309136v1
  #   cond-mat/0211034
  OLD_IDENTIFIER_FORMAT = /^[a-z]+(\-[a-z]+)?\/\d{7}(v\d+)?$/

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
      query ||= Query.new(*ids, sort_by: sort_by, sort_order: sort_order)
      raise TypeError.new("Expected `query` to be an Arx::Query, got: #{query.class}") unless query.is_a? Query

      yield query if block_given?

      document = Nokogiri::XML(open ENDPOINT + query.to_s + '&max_results=10000').remove_namespaces!
      results = Paper.parse(document, single: ids.size == 1)

      if results.is_a? Paper
        raise Error::MissingPaper.new(ids.first) if results.title.empty?
      elsif results.is_a? Array
        results.reject! {|paper| paper.title.empty?}
      elsif results.nil?
        if ids.size == 1
          raise Error::MissingPaper.new(ids.first)
        else
          results = []
        end
      end

      results
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