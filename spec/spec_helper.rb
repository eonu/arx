$LOAD_PATH.unshift File.join __dir__, '..', 'lib'
require 'bundler/setup'
require 'arx'

# Load support files from spec/support
Dir.glob File.join(__dir__, 'support', '*.rb'), &method(:require)

RSpec.configure do |config|
  # Configure RSpec here...
end

include Arx