require 'cgi'
require 'uri'
require 'net/http'
require 'net/https'

module SmsNotify
  class Api
    # Takes care of the trenchwork in executing an API
    # operation through the API in the form of an HTTP GET request.
    class Command
      # Create a new instance that can be used to interact with the
      # API.
      #
      # == Required Attributes
      # * cmd_name
      # * license_key
      # 
      # == Optional Attributes
      # * secure (defaults to true)
      # * opts - hash of extra options (not currently used)
      #
      # == Example
      #   command = Command.new('SendSMSBasic', 'secret_key', false)
      def initialize(cmd_name, license_key, secure=true, opts={})
        @name = cmd_name
        @license_key = license_key
        @secure = secure
        @options = opts
      end

      # Builds a URL fit for sending to CDYNE SmsNotify! API
      # and returns the body of the HTTP response.
      def execute(parameters)
        url = build_url(parameters)
        response = get_response(url)
        handle_errors(response[0]).body
      end

      # Builds an escaped query string from a hash and
      # returns a full URL complete with host, path, license_key
      # and command provided at initialization.
      def build_url(params_hash)
        param_string = '?' + params_hash.merge(:LicenseKey => @license_key).map { |k, v| "#{::CGI.escape(k.to_s)}=#{::CGI.escape(v.to_s)}" }.sort.join('&')
        URI.parse(File.join(endpoint_url, @name + param_string))
      end

      protected
      # Actually executes an HTTP GET to specified URL
      # and returns the HTTP response code and response body.
      # Note that redirects are not followed.
      def get_response(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == 'https')
        http.start do |http|
          resp, body = http.get([uri.path, uri.query].join('?'))
        end
      end
      
      private
      # Raises an SmsNotify::ConnectionError if HTTP response
      # is not a success (response code must be 2XX).
      def handle_errors(http_response_object)
        if http_response_object.class.superclass == Net::HTTPSuccess
          http_response_object
        else
          raise SmsNotify::ConnectionError
        end
      end

      # Builds the host url including protocol, determining if
      # HTTP or HTTPS should be used.
      def endpoint_url
        protocol = @secure ? 'https' : 'http'
        endpoint_host = SmsNotify::Api.endpoint_host
        "#{protocol}://#{endpoint_host}/"
      end
    end
  end
end