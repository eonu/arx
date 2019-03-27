# Restricts `#inspect` to dump a whitelist of methods on an object.
# It will always provide `object_id` at a minimum.
module Inspector

  # Overwrites the object's own inspect method.
  def inspect
    pairs = {}

    self.class.inspector_fields.each do |field|
      pairs[field] = self.send(field).inspect
    rescue
    end

    "#<#{self.class.name}:#{self.object_id} #{pairs.map {|k,v| "#{k}=#{v}"}.join(", ")}>"
  end

  class << self
    # Returns the +inspected+ instance variable, or sets it if undefined.
    def inspected
      @inspected ||= []
    end

    # Defines helper +inspector_fields+ instance variable & method, and +inspector+ instance method on the target object.
    # @param [Object] source An arbitrary object (the object that +includes+ the +Inspector+ module).
    def included(source)
      inspected << source
      source.class_eval do
        def self.inspector(*fields)
          @inspector_fields = *fields
        end

        def self.inspector_fields
          @inspector_fields ||= []
        end
      end
    end
  end
end