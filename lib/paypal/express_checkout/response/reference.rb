module PayPal
  module ExpressCheckout
    module Response
      class Reference < PayPal::ExpressCheckout::Response::Base
        has_fields :reference, :payment

        has_many :fmfs
      end
    end
  end
end