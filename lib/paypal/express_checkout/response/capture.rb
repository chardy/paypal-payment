module PayPal
  module ExpressCheckout
    module Response
      class Capture < PayPal::ExpressCheckout::Response::Base
        has_fields :payment, :amount

        def pending?
          payment_status == 'Pending'
        end

      end
    end
  end
end
