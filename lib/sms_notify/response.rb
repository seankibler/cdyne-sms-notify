require 'xmlsimple'
module SmsNotify
  # Handles parsing a CDYNE SmsNotify! XML response
  # into a Ruby-like hash.
  class Response
    class << self
      # Converts XML into a Ruby-like hash
      def parse(xml_response_body)
        response_hash = xml_to_hash(xml_response_body)
        response_hash
      end

      # Uses the XmlSimple class to convert an
      # xml document into a hash
      def xml_to_hash(xml)
        parser = XmlSimple.new({'ForceArray' => false, 'KeepRoot' => true, 'SuppressEmpty' => nil})
        normalize_keys(parser.xml_in(xml))
      end

      private
      # Transforms camel-cased keys in a single
      # nested hash into underscored keys.
      # 
      # == Examples:
      #   normalize_keys({"CamelCased"=> {"KeyOne"=>"value","keyTwo"=>"value"}})
      #   => {"camel_cased" => {"key_one"=>"value", "key_two"=>"value"}}
      def normalize_keys(hash)
        new_hash = {}
        hash.first[1].each_pair { |k,v| new_hash.merge!(underscore(k) => v) }
        {underscore(hash.first[0]) => new_hash}
      end

      # Stolen from Rails 2.3.5
      # 
      # http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html
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
