module Arx

  # Class for cleaning strings.
  # @private
  class Cleaner

    # arXiv paper URL prefix format
    URL_PREFIX = /^(https?\:\/\/)?(www.)?arxiv\.org\/abs\//

    class << self

      # Cleans strings.
      # @param [String] string Removes newline/return characters and multiple spaces from a string.
      # @return [String] The cleaned string.
      def clean(string)
        string.gsub(/\r\n|\r|\n/, ' ').strip.squeeze ' '
      end

      # Attempt to extract an arXiv identifier from a string such as a URL.
      #
      # @param string [String] The string to extract the ID from.
      # @param version [Boolean] Whether or not to include the paper's version.
      # @return [String] The extracted ID.
      def extract_id(string, version: false)
        raise TypeError.new("Expected `version` to be boolean (TrueClass or FalseClass), got: #{version.class}") unless version == !!version
        raise TypeError.new("Expected `string` to be a String, got: #{string.class}") unless string.is_a? String
        string.gsub!(/(#{URL_PREFIX})|(\/$)/, '') if /#{URL_PREFIX}.+\/?$/.match? string
        raise ArgumentError.new("Couldn't extract arXiv identifier from: #{string}") unless Validate.id? string
        version ? string : string.sub(/v[0-9]+$/, '')
      end

      # Attempt to extract a version number from an arXiv identifier.
      #
      # @param string [String] The arXiv identifier to extract the version number from.
      # @return [String] The extracted version number.
      def extract_version(string)
        reversed = extract_id(string, version: true).reverse

        if /^[0-9]+v/.match? reversed
          reversed.partition('v').first.to_i
        else
          raise ArgumentError.new("Couldn't extract version number from identifier: #{string}")
        end
      end
    end
  end
end