require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.join __dir__, '..', 'lib'
require 'bundler/setup'
require 'arx'

include Arx