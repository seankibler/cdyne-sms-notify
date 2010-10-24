require 'rubygems'
require 'rspec'
require 'mocha'
require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + '/../lib/sms_notify')

RSpec.configure do |config|
  config.mock_with :mocha
end
