module PayPal
  module ExpressCheckout
    class PaymentItem < PayPal::ExpressCheckout::Base
      has_fields :payment_item, :amount
    end
  end
end