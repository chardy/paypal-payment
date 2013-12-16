module PayPal
  module Invoice
    class Api

      API_ENDPOINTS = {
         :sandbox     => "https://svcs.sandbox.paypal.com/Invoice",
         :production  => "https://svcs.paypal.com/Invoice"
      }

      DATA_FORMATS = {
        :nvp  => 'NV',
        :xml  => 'XML',
        :json => 'JSON'
      }

      class << self
        def username
          PayPal::Api.instance.username
        end

        def password
          PayPal::Api.instance.password
        end

        def signature
          PayPal::Api.instance.signature
        end

        def app_id
          PayPal::Api.instance.app_id
        end

        def environment
          PayPal::Api.environment
        end

        def api_endpoint
          API_ENDPOINTS[environment]
        end

        def request_data_format
          DATA_FORMATS[:json]
        end

        def response_data_format
          DATA_FORMATS[:json]
        end
      end
    end
  end
end