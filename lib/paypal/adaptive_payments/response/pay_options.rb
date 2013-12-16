include PayPal::AdaptivePayments::Response

module PayPal::AdaptivePayments::Response
  class PayOptions < PayPal::AdaptivePayments::PaymentOptions
    include PayPal::Common::Response
  end
end