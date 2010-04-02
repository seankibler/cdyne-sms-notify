require 'rubygems'

# Creates a wrapper namespace for the
# rest of the API classes.
module SmsNotify
  Dir.glob(File.join(File.dirname(__FILE__), '/sms_notify/*')).each do |lib|
    require lib
  end
  
  class ConnectionError < StandardError;end
  class ApiError < StandardError;end
end