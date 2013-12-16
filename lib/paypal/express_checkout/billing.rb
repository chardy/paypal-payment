module PayPal
  module ExpressCheckout
    class Billing < PayPal::ExpressCheckout::Base
      has_fields :billing
    end
  end
end