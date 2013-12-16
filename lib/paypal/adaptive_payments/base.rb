module PayPal::AdaptivePayments
  class Base
    include PayPal::Common::Base

    attr_accessor :request_envelope

    def request
      PayPal::AdaptivePayments::Request.new
    end
  end
end