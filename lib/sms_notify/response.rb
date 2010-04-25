require 'xmlsimple'
module SmsNotify
  # Handles parsing a CDYNE SmsNotify! XML response
  # into a Ruby-like hash.
  class Response
    class << self
	    # Converts XML into a Ruby-like hash
	    def parse(response)
	      if response.is_a?(SOAP::Mapping::Object)
          soap_response = SoapResponse.new(response)
          soap_response.to_hash
	      else
	        parser = XmlSimple.new({'ForceArray' => false, 'KeepRoot' => true, 'SuppressEmpty' => nil})
	        parser.xml_in(response)
	      end
	    end
	  end
  end
end
