module SmsNotify
  # Represents an SMS message status in the form
  # of a Ruby-like object.
  class MessageStatus
    attr_reader :completed, :demo, :scheduled_time, :status_code, :status_text, :text_id, :received_date, :responded

    # Create a new instance of a #MessageStatus
    #
    # == Example
    #   SmsNotify::MessageStatus.new(
    #     :completed => '1',
    #     :demo => '0',
    #     :scheduled_time => '2010-04-03T14:29:14.7',
    #     :status_code => '6',
    #     :status_text => 'Completed',
    #     :received_date => '2010-04-03T14:29:14.7',
    #     :responded => '0')
    def initialize(attrs)
      @completed      = attrs[:completed] || nil
      @demo           = attrs[:demo] || nil
      @scheduled_time = attrs[:scheduled_time] || nil
      @status_code    = attrs[:status_code] || nil
      @status_text    = attrs[:status_text] || nil
      @text_id        = attrs[:text_id] || nil
      @received_date  = attrs[:received_date] || nil
      @responded      = attrs[:responded] || nil
    end
  end
end
