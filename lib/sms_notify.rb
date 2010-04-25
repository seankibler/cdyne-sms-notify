require 'rubygems'

# Creates a wrapper namespace for the
# rest of the API classes.
module SmsNotify
  ['sms_notify', 'ext'].each { |dir|
    Dir.glob(File.join(File.dirname(__FILE__), "/#{dir}/*")).each do |lib|
      require lib
    end
  }
  
  class ConnectionError < StandardError;end
  class ApiError < StandardError;end
end
