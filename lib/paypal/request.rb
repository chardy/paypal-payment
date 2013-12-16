module PayPal
  class Request

    CA_FILE = File.dirname(__FILE__) + "/cacert.pem"

    attr_accessor :uri

    # Do a POST request to PayPal API.
    # The +method+ argument is the name of the API method you want to invoke.
    # For instance, if you want to request a new checkout token, you may want
    # to do something like:
    #
    #   response = request.run(:express_checkout)
    #
    # We normalize the methods name. For a list of what's being covered, refer to
    # PayPal::Recurring::Request::METHODS constant.
    #
    # The params hash can use normalized names. For a list, check the
    # PayPal::Recurring::Request::ATTRIBUTES constant.
    #
    def run(method, params = {}, headers = {})
      params = prepare_params(params.merge(:method => api_methods.fetch(method, method.to_s)))
      headers = prepare_headers(headers)
      response = post(params, headers)
      Response.process(method, response)
    end

    # Post to PayPal api
    #
    def post(params = {}, headers = {})
      Curl.post(uri, params) do |http|
        http.ssl_verify_host = true
        http.ssl_verify_peer = true
        http.cacert = CA_FILE
        headers.each { |key, value| http.headers[key] = value }
      end
    end

    # Join headers
    #
    def prepare_headers(headers) # :nodoc:
      default_headers.merge(headers)
    end

    # Default header for setting user agent
    #
    def default_headers # :nodoc:
      {
        'User-Agent' => "PayPal::Payment/0.1"
      }
    end

    # Join params and normalize attribute names.
    #
    def prepare_params(params) # :nodoc:
      normalize_params default_params.merge(params)
    end

    # Parse current API url.
    #
    def uri # :nodoc:
      @uri ||= PayPal::Api.site_endpoint
    end

    def normalize_params(params)
      params.inject({}) do |buffer, (name, value)|
        attr_names = [ATTRIBUTES[name.to_sym]].flatten.compact
        attr_names << name if attr_names.empty?

        attr_names.each do |attr_name|
          buffer[attr_name.to_sym] = respond_to?("build_#{name}") ? send("build_#{name}", value) : value
        end

        buffer
      end
    end

    def api_methods
      {}
    end
  end
end
