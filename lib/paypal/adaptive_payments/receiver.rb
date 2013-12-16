module PayPal::AdaptivePayments
  class Receiver
    include PayPal::Common::Base

    attr_accessor :amount
    attr_accessor :email
    attr_accessor :invoice_id
    attr_accessor :payment_type
    attr_accessor :payment_sub_type
    attr_accessor :phone
    attr_accessor :primary

    def set_phone(value)
      self.phone = build_value(PayPal::AdaptivePayments::Phone, value)
    end
  end
end