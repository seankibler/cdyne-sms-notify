require 'cgi'
require 'uri'
require 'net/http'
require 'net/https'

module SmsNotify
  class Api
    # Takes care of the trenchwork in sending API
    # operations to the API using HTTP GET request.
    class Command
      def initialize(cmd_name, license_key, secure=true, opts={})
        @name = cmd_name
        @license_key = license_key
        @secure = secure
        @options = opts
      end

      # Builds a URL fit for sending to CDYNE SmsNotify! API
      # and returns the body of the HTTP response.
      def execute(parameters)
        url = add_params(parameters)
        get_response(url)
      end

      # Builds an escaped query string from a hash and
      # returns a full URL complete with host, path, license_key
      # and command provided at initialization.
      def add_params(params_hash)
        param_string = '?' + params_hash.merge(:LicenseKey => @license_key).map { |k, v| "#{::CGI.escape(k.to_s)}=#{::CGI.escape(v.to_s)}" }.sort.join('&')
        URI.parse(File.join(endpoint_url, @name + param_string))
      end

      protected
      # Actually executes an HTTP GET to specified URL
      # and returns the HTTP response code and response body.
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