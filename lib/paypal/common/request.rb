module PayPal::Common
  class Request < PayPal::Request

    def api
      PayPal::Api
    end

    def default_headers
      super.merge(
        {
          'X-PAYPAL-SECURITY-USERID'      => api.username,
          'X-PAYPAL-SECURITY-PASSWORD'    => api.password,
          'X-PAYPAL-SECURITY-SIGNATURE'   => api.signature,
          'X-PAYPAL-REQUEST-DATA-FORMAT'  => api.request_data_format,
          'X-PAYPAL-RESPONSE-DATA-FORMAT' => api.response_data_format,
          'X-PAYPAL-APPLICATION-ID'       => api.app_id
        }
      )
    end

    # Returns the actual api endpoint base on method
    #
    def method_endpoint(method)
      api.api_endpoint
    end

    def prepare_json(json)
      json[:requestEnvelope] = PayPal::Common::RequestEnvelope.new.to_hash unless json[:requestEnvelope]
      json
    end

    def build_json(json)
      json.is_a?(Hash) ? build_json(json) : json
    end

    def run(method, json = {})
      self.uri = method_endpoint(method)
      post(MultiJson.dump(prepare_json(json)), default_headers)
    end

    def build_action_type(value)
      ACTION_TYPES.fetch(value.to_sym, value) if value
    end
  end
end