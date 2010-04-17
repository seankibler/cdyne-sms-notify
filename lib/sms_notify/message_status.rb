module SmsNotify
  # Represents an SMS message status in the form
  # of a Ruby-like object.
  class MessageStatus
    FATAL_ERRORS = ['3', '7', '8', '9', '10', '11', '12', '13', '14']
    attr_reader :completed, :demo, :scheduled_time, :status_code, :status_text, :text_id, :received_date, :responded

    # Create a new instance of a #MessageStatus
    #
    # == Example
    #   SmsNotify::MessageStatus.new(
    #     :Completed => '1',
    #     :Demo => '0',
    #     :ScheduledTime => '2010-04-03T14:29:14.7',
    #     :StatusCode => '6',
    #     :StatusText => 'Completed',
    #     :ReceivedDate => '2010-04-03T14:29:14.7',
    #     :Responded => '0')
    def initialize(attrs)
      @completed      = attrs[:Completed] || nil
      @demo           = attrs[:demo] || nil
      @scheduled_time = attrs[:ScheduledTime] || nil
      @status_code    = attrs[:StatusCode] || nil
      @status_text    = attrs[:StatusText] || nil
      @text_id        = attrs[:text_id] || nil
      @received_date  = attrs[:ReceivedDate] || nil
      @responded      = attrs[:Responded] || nil
    end

    def fatal_error?
      FATAL_ERRORS.include?(self.status_code)
    end
  end
end
