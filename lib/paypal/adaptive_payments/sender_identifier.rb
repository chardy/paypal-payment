module PayPal::AdaptivePayments
  class SenderIdentifier
    include PayPal::Common::Base

    attr_accessor :use_credentials
  end
end
