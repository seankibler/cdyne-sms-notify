module SmsNotify
  Dir.glob(File.join(File.dirname(__FILE__), '/sms_notify/*')).each do |lib|
    require lib
  end
  
  class ConnectionError < StandardError;end
  class ApiError < StandardError;end
end