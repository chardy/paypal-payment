module PayPal::Invoice
  class PaymentDetails < PayPal::Invoice::Base

    attr_accessor :via_paypal
    attr_accessor :paypal_payment
    attr_accessor :other_payment

    def set_paypal_payment(value)
      self.paypal_payment = build_value(PaypalPaymentDetails, value)
    end

    def set_other_payment(value)
      self.other_payment = build_value(OtherPaymentDetails, value)
    end
  end
end