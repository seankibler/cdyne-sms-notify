require 'soap/wsdlDriver'
require 'time'

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
    attr_accessor :license_key, :soap_driver

    def self.endpoint_host #:nodoc:
      'ws.cdyne.com/SmsWs/SMS.asmx'
    end

    # Create a new API instance.
    #
    # == Required Attributes
    # * license_key
    #
		# == Optional Attributes
		# * wsdl_url
		#
    # == Examples:
    #   api = SmsNotify::Api.new('my_secret_license_key')
    def initialize(license_key, wsdl_url='http://ws.cdyne.com/SmsWS/SMS.asmx?wsdl')
      @license_key = license_key
			@soap_driver = SOAP::WSDLDriverFactory.new(wsdl_url).create_rpc_driver
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

		# Implements +SendSMSAdvanced+[http://ws.cdyne.com/SmsWS/SMS.asmx?op=SendSMSAdvanced].
		#
		# == Required Attributes
		# * phone_number
		# * message
		#
		# == Optional Attributes
		# * scheduled_time
		# * allow_responses
		# * status_post_url
    #
    # == Example
    #   options = { 
    #     :enable_responses => true, 
    #     :deliver_at       => Time.now + 60, 
    #     :status_post_url  => 'http://foo.com' 
    #   }
    # 
    #   @api.send_advanced_message('1234567890', 'Affirmative!', options)
		def send_advanced_message(phone_number, message, options={})
      # set some default options but let passed in options override them
			opts = {
				:enable_responses => false, 
				:deliver_at       => Time.now,
				:status_post_url  => ''
			}.merge(options) 

			result = soap_driver.sendSMSAdvanced( :Request => {
				:PhoneNumber			=> phone_number,
				:Message					=> message,
				:Licensekey				=> license_key,
				:ScheduledTime		=> opts[:deliver_at].utc.xmlschema(2),
				:Response					=> opts[:enable_responses] ? 1 : 0,
				:ResponsePostURL	=> opts[:status_post_url]
				}
			)
      MessageStatus.new(Response.parse(result))
		end

    # Implements +GetSMSStatus+[http://ws.cdyne.com/SmsWS/SMS.asmx?op=GetSMSStatus].
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
        )["SmsReturn"]
      )
    end

    # Implements +GetSMSResponse+[http://ws.cdyne.com/SmsWS/SMS.asmx?op=GetSMSResponse].
    #
    # == Required Attributes
    # * text_id
    #
    # Returns an array of #MessageStatus objects.
    #
    # == Example:
    #   @api.message_responses("c7d8a")
    def message_responses(text_id)
      command = Command.new('GetSMSResponse', license_key)
      responses = Response.parse( 
        command.execute({:TextID => text_id}) 
      )["ArrayOfSmsResponse"]["SmsResponse"] || []

			responses.is_a?(Array) ? responses.collect { |r| MessageResponse.new(r) } : MessageResponse.new(responses)
    end

    Dir.glob(File.join(File.dirname(__FILE__), '/api/*')).each do |lib|
      require lib
    end
  end
end
