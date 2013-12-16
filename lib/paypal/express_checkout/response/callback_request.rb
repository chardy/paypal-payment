module PayPal
  module ExpressCheckout
    module Response
      class CallbackRequest < PayPal::ExpressCheckout::Response::Base
        has_fields :callback, :ship_to
        has_many :payment_items
      end
    end
  end
end
