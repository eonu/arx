$LOAD_PATH.unshift File.join __dir__, '..', 'lib'
require 'bundler/setup'
require 'arx'

RSpec.configure do |config|
  # Configure RSpec here...
end

include Arx