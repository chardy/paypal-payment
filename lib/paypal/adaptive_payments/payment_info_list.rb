module PayPal::AdaptivePayments
  class PaymentInfoList
    include PayPal::Common::Base

    attr_accessor :payment_info

    def set_payment_info(value)
      self.payment_info = build_value(PaymentInfo, value)
    end
  end
end
