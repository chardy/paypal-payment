module PayPal
  module ExpressCheckout
    module Response
      class ManageProfile < PayPal::ExpressCheckout::Response::Base
        has_fields :recurring
      end
    end
  end
end
