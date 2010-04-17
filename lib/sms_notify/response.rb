require 'xmlsimple'
module SmsNotify
  # Handles parsing a CDYNE SmsNotify! XML response
  # into a Ruby-like hash.
  class Response
    # Converts XML into a Ruby-like hash
    def self.parse(xml_response_body)
      parser = XmlSimple.new({'ForceArray' => false, 'KeepRoot' => true, 'SuppressEmpty' => nil})
      parser.xml_in(xml_response_body)
    end
  end
end
