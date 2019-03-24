require 'happymapper'
require 'arx/exceptions'
require 'arx/cleaner'
require_relative 'author'
require_relative 'category'
require_relative 'link'

module Arx

  # Entity/model representing an arXiv paper.
  class Paper
    include HappyMapper

    tag 'entry'

    element :id, Cleaner, parser: :clean, tag: 'id'
    # The identifier of the paper.
    # @note This is either in {Validate::OLD_IDENTIFIER_FORMAT} or {Validate::NEW_IDENTIFIER_FORMAT}.
    # @example
    #   1705.01662v1
    #   cond-mat/0211034
    # @return [String] The paper's identifier.
    def id
      @id.sub /https?\:\/\/arxiv\.org\/abs\//, ''
    end

    # The URL of the paper on the arXiv website.
    # @example
    #   http://arxiv.org/abs/1705.01662v1
    #   http://arxiv.org/abs/cond-mat/0211034
    # @return [String] The paper's arXiv URL.
    def url
      @id
    end

    # @!method last_updated
    # The date that the paper was last updated.
    # @return [DateTime]
    element :last_updated, DateTime, tag: 'updated'

    # @!method publish_date
    # The original publish/submission date of the paper.
    # @return [DateTime]
    element :publish_date, DateTime, tag: 'published'

    # @!method title
    # The title of the paper.
    # @return [DateTime]
    element :title, Cleaner, parser: :clean, tag: 'title'

    # @!method authors
    # The authors of the paper.
    # @return [Array<Author>]
    has_many :authors, Author, tag: 'author'

    # @!method primary_category
    # The primary category of the paper.
    # @return [Category]
    element :primary_category, Category, tag: 'primary_category'

    # @!method categories
    # The categories of the paper.
    # @return [Array<Category>]
    has_many :categories, Category, tag: 'category'

    # Whether the paper is a revision or not.
    # @note A paper is a revision if {last_updated} differs from {publish_date}.
    # @return [Boolean]
    def revision?
      @publish_date != @last_updated
    end

    # @!method summary
    # The summary (or abstract) of the paper.
    # @return [String]
    element :summary, Cleaner, parser: :clean, tag: 'summary'
    alias_method :abstract, :summary

    # @!method comment?
    # Whether or not the paper has a comment.
    # @return [Boolean]

    # @!method comment
    # The comment of the paper.
    # @note This is an optional metadata field on an arXiv paper. To check whether the paper has a comment, use {comment?}
    # @raise {MissingFieldError} If the paper does not have a comment.
    # @return [String]
    element :comment, Cleaner, parser: :clean, tag: 'comment'

    # @!method journal?
    # Whether or not the paper has a journal reference.
    # @return [Boolean]

    # @!method journal
    # The journal reference of the paper.
    # @note This is an optional metadata field on an arXiv paper. To check whether the paper has a journal reference, use {journal?}
    # @raise {MissingFieldError} If the paper does not have a journal reference.
    # @return [String]
    element :journal, Cleaner, parser: :clean, tag: 'journal_ref'

    %i[comment journal].each do |optional|
      exists = "#{optional}?"

      define_method exists do
        !instance_variable_get("@#{optional}").empty?
      end

      define_method optional do
        if self.send "#{optional}?"
          instance_variable_get("@#{optional}")
        else
          raise MissingFieldError.new(optional)
        end
      end
    end

    has_many :links, Link, tag: 'link'

    # @!method pdf?
    # Whether or not the paper has a PDF link.
    # @return [Boolean]

    # @!method pdf_url
    # Link to the PDF version of the paper.
    # @note This is an optional metadata field on an arXiv paper. To check whether the paper has a PDF link, use {pdf?}
    # @raise {MissingLinkError} If the paper does not have a PDF link.
    # @return [String]

    # @!method doi?
    # Whether or not the paper has a DOI (Digital Object Identifier) link.
    # @see https://arxiv.org/help/jref#doi
    # @see https://arxiv.org/help/prep#doi
    # @return [Boolean]

    # @!method doi_url
    # Link to the DOI (Digital Object Identifier) of the paper.
    # @see https://arxiv.org/help/jref#doi
    # @see https://arxiv.org/help/prep#doi
    # @note This is an optional metadata field on an arXiv paper. To check whether the paper has a DOI link, use {doi?}
    # @raise {MissingLinkError} If the paper does not have a DOI link.
    # @return [String]

    %i[pdf doi].each do |link_type|
      exists = "#{link_type}?".to_sym

      define_method exists do
        links.any? &exists
      end

      define_method "#{link_type}_url" do
        if self.send exists
          links.find(&exists).href
        else
          raise MissingLinkError.new link_type.to_s.upcase
        end
      end
    end
  end
end