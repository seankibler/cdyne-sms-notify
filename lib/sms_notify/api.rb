module SmsNotify

  # A lazy class that uses OpenStruct
  # to allow passing in an arbitrary hash
  # of attributes and get a usable object
  # out of it.
  #
  class MessageStatus < OpenStruct
  end

  # Provides the methods that implement each of
  # the operations of the CDYNE SmsNotify! API.
  # API Spec PDF - http://www.cdyne.com/downloads/SPECS_SMS-Notify.pdf
  # API Operations - http://ws.cdyne.com/SmsWS/SMS.asmx
  # API WSDL - http://ws.cdyne.com/SmsWS/SMS.asmx?WSDL
  class Api
    attr_accessor :license_key

    def self.endpoint_host #:nodoc:
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