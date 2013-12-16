module PayPal
  module Permissions
    class Api

      SITE_ENDPOINTS = {
         :sandbox => "https://www.sandbox.paypal.com/cgi-bin/webscr",
         :production => "https://www.paypal.com/cgi-bin/webscr"
      }

      API_ENDPOINTS = {
         :sandbox => "https://svcs.sandbox.paypal.com/Permissions",
         :production => "https://svcs.paypal.com/Permissions"
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

        def site_endpoint
          SITE_ENDPOINTS[environment]
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