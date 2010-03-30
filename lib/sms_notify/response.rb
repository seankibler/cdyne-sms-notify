require 'xmlsimple'
module SmsNotify
  class Response
    class << self
      # Accepts the response body from
      # CDYNE and turns it into a hash
      def parse(xml_response_body)
        response_hash = xml_to_hash(xml_response_body)
        response_hash.first[1].delete("xmlns")
        response_hash
      end

      def xml_to_hash(xml)
        parser = XmlSimple.new({'ForceArray' => false, 'KeepRoot' => true, 'SuppressEmpty' => nil})
        normalize_keys(parser.xml_in(xml))
      end

      private
      def normalize_keys(hash)
        new_hash = {}
        hash.first[1].each_pair { |k,v| new_hash.merge!(underscore(k) => v) }
        {underscore(hash.first[0]) => new_hash}
      end

      def underscore(camel_cased_word)
        camel_cased_word.to_s.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
      end
    end
  end
end
