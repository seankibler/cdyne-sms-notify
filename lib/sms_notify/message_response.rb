module SmsNotify
  # Represents an SMS message response (text reply) in the form
  # of a Ruby-like object.
  class MessageResponse
    attr_reader :response_id, :text_id, :status_code, :received_date, :message

    # Create a new instance of a #MessageResponse
    #
    # == Example
    #   SmsNotify::MessageResponse.new(
    #     :response_id => '1',
    #     :text_id => '123',
    #     :status_code => '6',
    #     :received_date => '2010-04-03T14:29:14.7',
    #     :message => 'foo')
    def initialize(attrs)
      @response_id    = attrs[:response_id] || nil
      @text_id        = attrs[:text_id] || nil
      @status_code    = attrs[:status_code] || nil
      @received_date  = attrs[:received_date] || nil
      @message        = attrs[:message] || nil
    end
  end
end