require 'singleton'

module PayPal
  class Api
    include Singleton

    SANDBOX_APP_ID = 'APP-80W284485P519543T'

    SITE_ENDPOINTS = {
      :sandbox => "https://www.sandbox.paypal.com/webscr",
      :production => "https://www.paypal.com/webscr"
    }

    # Define if requests should be made to PayPal's
    # sandbox environment. This is specially useful when running
    # on development or test mode.
    #
    #   PayPal::Api.sandbox = true
    #
    attr_accessor :sandbox

    # Set PayPal's API username.
    #
    attr_accessor :username

    # Set PayPal's API password.
    #
    attr_accessor :password

    # Set PayPal's API signature.
    #
    attr_accessor :signature

    # Set seller id. Will be used to verify IPN.
    #
    attr_accessor :seller_id

    # The seller e-mail. Will be used to verify IPN.
    #
    attr_accessor :email

    # Set PayPal's API app id. (required for Adaptive / Invoice)
    #
    attr_accessor :app_id

    class << self
      # Set PayPal's API attributes
      #
      # PayPal::Api.configure do |config|
      #   config.username = "test@api.com"
      #   config.password = "testing"
      #   config.signature = "AAAAAAA"
      #   config.email = "test@api.com"
      # end
      def configure(&block)
        instance.configure(&block)
      end

      def sandbox=(testing)
        instance.sandbox = testing
      end

      def environment
        instance.environment
      end

      def site_endpoint
        SITE_ENDPOINTS[environment]
      end
    end

    def configure(&block)
      yield self
    end

    # Detect if sandbox mode is enabled.
    #
    def sandbox?
      sandbox == true
    end

    # Return a name for current environment mode (sandbox or production).
    #
    def environment
      sandbox? ? :sandbox : :production
    end

    # Return application id
    #
    def app_id
      sandbox? ? SANDBOX_APP_ID : @app_id ||= SANDBOX_APP_ID
    end
  end
end