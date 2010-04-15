module SmsNotify #:nodoc:
  module Version #:nodoc:
    MAJOR = 0
    MINOR = 8
    TINY  = 4

    STRING = [MAJOR, MINOR, TINY].join('.')

    def self.to_s
      STRING
    end
  end
end
