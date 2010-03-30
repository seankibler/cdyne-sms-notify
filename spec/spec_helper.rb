require 'rubygems'
require 'spec'
require 'mocha'
require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + '/../lib/sms_notify')

Spec::Runner.configure do |config|
  config.mock_with :mocha
end