module PayPal::AdaptivePayments
  class SenderOptions
    include PayPal::Common::Base

    attr_accessor :require_shipping_address_selection
    attr_accessor :referrer_code
  end
end
