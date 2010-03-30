module SmsNotify
  class Api
    attr_accessor :license_key
    
    def self.endpoint_host
      'ws.cdyne.com/SmsWs/SMS.asmx'
    end
    
    def initialize(license_key)
      @license_key = license_key
    end

    def send_message()
      
    end

    Dir.glob(File.join(File.dirname(__FILE__), '/api/*')).each do |lib|
      require lib
    end
  end
end