module SmsNotify
  class MessageStatus
    def initialize(attrs_hash={})
      OpenStruct.new(attrs_hash)
    end
  end
end