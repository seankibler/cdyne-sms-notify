module SmsNotify
  # Represents an SMS message response (text reply) in the form
  # of a Ruby-like object.
  class MessageResponse
    attr_reader :response_id, :text_id, :status_code, :received_date, :message

    # Create a new instance of a #MessageResponse
    #
    # == Example
    #   SmsNotify::MessageResponse.new(
    #     "ResponseID"    => '1',
    #     "TextID"        => '123',
    #     "StatusCode"    => '6',
    #     "ReceivedDate"  => '2010-04-03T14:29:14.7',
    #     "Message"       => 'foo')
    def initialize(attrs)
      @response_id    = attrs["ResponseID"]   || nil
      @text_id        = attrs["TextID"]       || nil
      @status_code    = attrs["StatusCode"]   || nil
      @received_date  = attrs["ReceivedDate"] || nil
      @message        = attrs["Message"]      || nil
    end
  end
end
