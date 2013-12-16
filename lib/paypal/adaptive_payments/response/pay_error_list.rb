module PayPal::AdaptivePayments::Response
  class PayErrorList
    include PayPal::Common::Base

    attr_accessor :pay_error

    def set_pay_error(value)
      self.pay_error = build_value(PayError, value)
    end

    def errors
      self.pay_error
    end
  end
end