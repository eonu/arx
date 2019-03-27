module Arx

  # Validations for arXiv search query fields and identifier schemes.
  # @private
  module Validate
    class << self
      # Validates the +sortBy+ field of the query string.
      #
      # @param value [Symbol] The value to validate.
      # @param permitted [Array<Symbol>] Permitted values for the field.
      # @raise
      #   [TypeError] If the value is not a +Symbol+.
      #   [ArgumentError] If the value is not permitted.
      def sort_by(value, permitted:)
        raise TypeError.new("Expected `sort_by` to be a Symbol, got: #{value.class}") unless value.is_a? Symbol
        raise ArgumentError.new("Expected `sort_by` to be one of #{permitted}, got: #{value}") unless permitted.include? value
      end

      # Validates the +sortOrder+ field of the query string.
      #
      # @param value [Symbol] The value to validate.
      # @param permitted [Array<Symbol>] Permitted values for the field.
      # @raise
      #   [TypeError] If the value is not a +Symbol+.
      #   [ArgumentError] If the value is not permitted.
      def sort_order(value, permitted:)
        raise TypeError.new("Expected `sort_order` to be a Symbol, got: #{value.class}") unless value.is_a? Symbol
        raise ArgumentError.new("Expected `sort_order` to be one of #{permitted}, got: #{value}") unless permitted.include? value
      end

      # Validates a list of arXiv paper identifiers.
      #
      # @param ids [Array<String>] The identifiers to validate.
      # @raise
      #   [TypeError] If +ids+ is not an +Array+.
      #   [TypeError] If any identifier is not a +String+.
      #   [ArgumentError] If the identifier is invalid.
      def ids(ids)
        raise TypeError.new("Expected `ids` to be an Array, got: #{ids.class}") unless ids.is_a? Array
        ids.each do |id|
          raise TypeError.new("Expected identifier to be a String, got: #{id.class} (#{id})") unless id.is_a? String
          raise ArgumentError.new("Malformed arXiv identifier: #{id}") unless id? id
        end
      end

      # Validates the +exact+ parameter.
      #
      # @param value [Boolean] The value to validate.
      # @raise
      #   [TypeError] If the value is not a boolean (+TrueClass+ or +FalseClass+).
      def exact(value)
        raise TypeError.new("Expected `exact` to be boolean (TrueClass or FalseClass), got: #{value.class}") unless value == !!value
      end

      # Validates a logical connective.
      #
      # @param value [Symbol] The value to validate.
      # @param permitted [Array<Symbol>] Permitted values for the field.
      # @raise
      #   [TypeError] If the value is not a +Symbol+.
      #   [ArgumentError] If the value is not permitted.
      def connective(value, permitted:)
        raise TypeError.new("Expected `connective` to be a Symbol, got: #{value.class}") unless value.is_a? Symbol
        raise ArgumentError.new("Expected `connective` to be one of #{permitted}, got: #{value}") unless permitted.include? value
      end

      # Validates a list of values for the fields of the search query string.
      #
      # @param values [Array<String>] The values to validate.
      # @raise
      #   [TypeError] If +values+ is not an +Array+.
      #   [TypeError] If any value is not a +String+.
      def values(values)
        raise TypeError.new("Expected `values` to be an Array, got: #{values.class}") unless values.is_a? Array
        values.each do |value|
          raise TypeError.new("Expected value to be a String, got: #{value.class} (#{value})") unless value.is_a? String
        end
      end

      # Validates a list of arXiv categories.
      #
      # @note This is only called after {values}, so there is no need to check types.
      # @param categories [Array<String>] The categories to validate.
      # @raise [ArgumentError] If any category is unrecognized (not a valid arXiv category).
      # @see Arx::CATEGORIES
      def categories(categories)
        categories.each do |category|
          raise ArgumentError.new("Unrecognized arXiv category (#{category}). See Arx::CATEGORIES.") unless Arx::CATEGORIES.keys.include? category
        end
      end

      # Validates an arXiv identifier of both the old and new schemes.
      #
      # @see NEW_IDENTIFIER_FORMAT
      # @see OLD_IDENTIFIER_FORMAT
      def id?(id)
        NEW_IDENTIFIER_FORMAT.match?(id) || OLD_IDENTIFIER_FORMAT.match?(id)
      end
    end
  end
end