require_relative '../config/environment'
require 'rack/test'
require "pry"

RSpec.configure do |config|

  config.include Rack::Test::Methods

  config.order = 'default'
end
