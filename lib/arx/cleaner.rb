module Arx

  # Class for cleaning strings.
  # @private
  class Cleaner

    # Cleans strings.
    # @param [String] string Removes newline/return characters and multiple spaces from a string.
    # @return [String] The cleaned string.
    def self.clean(string)
      string.gsub(/\r\n|\r|\n/, ' ').strip.squeeze ' '
    end
  end
end