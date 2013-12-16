module PayPal
  module ExpressCheckout
    module Response
      class Checkout < PayPal::ExpressCheckout::Response::Base
        def checkout_url
          "#{PayPal::Api.site_endpoint}?cmd=_express-checkout&token=#{token}&useraction=commit"
        end
      end
    end
  end
end
