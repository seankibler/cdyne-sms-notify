module SMSNotify #:nodoc:
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 2
    TINY  = 1

    STRING = [MAJOR, MINOR, TINY].join('.')

    def self.to_s
      STRING
    end
  end
end
