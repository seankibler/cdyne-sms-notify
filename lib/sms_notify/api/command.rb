require 'cgi'
require 'uri'
require 'net/http'
require 'net/https'

module SmsNotify
  class Api
    class Command
      def initialize(cmd_name, license_key, secure=true, opts={})
        @name = cmd_name
        @license_key = license_key
        @secure = secure
        @options = opts
      end

      def execute(parameters)
        url = add_params(parameters)
        get_response(url)
      end

      def add_params(params_hash)
        param_string = '?' + params_hash.merge(:LicenseKey => @license_key).map { |k, v| "#{::CGI.escape(k.to_s)}=#{::CGI.escape(v.to_s)}" }.sort.join('&')
        URI.parse(File.join(endpoint_url, @name + param_string))
      end

      protected
      def get_response(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == 'https')
        http.start do |http|
          resp, body = http.get([uri.path, uri.query].join('?'))
        end
      end
      
      private
      def endpoint_url
        protocol = @secure ? 'https' : 'http'
        endpoint_host = SmsNotify::Api.endpoint_host
        "#{protocol}://#{endpoint_host}/"
      end
    end
  end
end