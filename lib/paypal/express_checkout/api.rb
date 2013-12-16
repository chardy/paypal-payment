module PayPal
  module ExpressCheckout
    class Api

      API_ENDPOINTS = {
         :sandbox     => "https://api-3t.sandbox.paypal.com/nvp",
         :production  => "https://api-3t.paypal.com/nvp"
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
          self::API_ENDPOINTS[environment]
        end

        # Return PayPal's API version.
        #
        def api_version
          "93.0"
        end
      end
    end
  end
end