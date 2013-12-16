module PayPal
  module ExpressCheckout
    class Fmf < PayPal::ExpressCheckout::Base
      has_fields :fmf
    end
  end
end