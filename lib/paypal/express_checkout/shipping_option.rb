module PayPal
  module ExpressCheckout
    class ShippingOption < PayPal::ExpressCheckout::Base
      has_fields :shipping_option
    end
  end
end