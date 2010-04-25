module SmsNotify
  class SoapResponse
    attr_accessor :soap_response

    # Retrieve the underlying soap object
    # from the wsdl driver.
    def initialize(soap_mapping_object)
      @soap_response = soap_mapping_object.send(
        soap_mapping_object.singleton_methods[0]
      )
    end

    # Convert this objects attributes
    # to ruby like hash.
    def to_hash
      response_hash = {}
      soap_mapping_attributes.each { |attr|
        response_hash.merge!(
          attr.underscore.to_sym => self.soap_response.send(attr)
        )
      }
      response_hash
    end

    # Grab all the getter methods defined for the
    # attributes of the underlying soap response object.
    def soap_mapping_attributes
      self.soap_response.singleton_methods.delete_if { |m|
        m =~ /=$/
      }
    end
  end
end
