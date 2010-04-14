module SmsNotify

  # Provides the methods that implement each of
  # the operations of the CDYNE SmsNotify! API.
  #
  # API Spec PDF - http://www.cdyne.com/downloads/SPECS_SMS-Notify.pdf
  #
  # API Operations - http://ws.cdyne.com/SmsWS/SMS.asmx
  #
  # API WSDL - http://ws.cdyne.com/SmsWS/SMS.asmx?WSDL
  class Api
    attr_accessor :license_key

    def self.endpoint_host #:nodoc:
      'ws.cdyne.com/SmsWs/SMS.asmx'
    end

    # Create a new API instance.
    #
    # == Required Attributes
    # * license_key
    #
    # == Examples:
    #   api = SmsNotify::Api.new('my_secret_license_key')
    def initialize(license_key)
      @license_key = license_key
    end

    # Implements +SendSMSBasic+[http://ws.cdyne.com/SmsWS/SMS.asmx?op=SendSMSBasic].
    #
    # == Required Attributes
    # * phone_number
    # * message
    # 
    # Returns an #MessageStatus object.
    #
    # == Example:
    #   api.send_message('1234567890', 'Hello world')
    def send_message(phone_number, message)
      command = Command.new('SendSMSBasic', license_key)
      MessageStatus.new(
        Response.parse(
          command.execute({:PhoneNumber => phone_number, :Message => message})
        )[:sms_return]
      )
    end

    # Implements +GetSMSStatus+[http://ws.cdyne.com/SmsWS/SMS.asmx?op=GetSMSStatus]
    #
    # == Required Attributes
    # * text_id
    #
    # Returns an #MessageStatus object.
    #
    # == Example:
    #   @api.message_status("c7d8a")
    def message_status(text_id)
      command = Command.new('GetSMSStatus', license_key)
      MessageStatus.new(
        Response.parse(
          command.execute({:TextID => text_id})
        )[:sms_return]
      )
    end

    def message_response(text_id)
      command = Command.new('GetSMSResponse', license_key)
      MessageResponse.new(Response.parse(command.execute({:TextID => text_id})))
    end

    Dir.glob(File.join(File.dirname(__FILE__), '/api/*')).each do |lib|
      require lib
    end
  end
end
