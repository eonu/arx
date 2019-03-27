module Arx

  # Helper entity/model representing a link on an arXiv paper.
  class Link
    include HappyMapper

    tag 'link'

    attribute :title, String
    attribute :rel,   String
    attribute :type,  String
    attribute :href,  String

    %w[pdf doi].each do |link_type|
      define_method "#{link_type}?" do
        @title == link_type
      end
    end
  end
end