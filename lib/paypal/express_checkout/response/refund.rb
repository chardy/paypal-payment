module PayPal
  module ExpressCheckout
    module Response
      class Refund < PayPal::ExpressCheckout::Response::Base
        has_fields :refund, :amount

        def completed?
          self.refund_status == "instant"
        end
      end
    end
  end
end