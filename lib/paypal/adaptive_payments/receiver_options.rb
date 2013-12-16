module PayPal::AdaptivePayments
  class ReceiverOptions
    include PayPal::Common::Base

    attr_accessor :description
    attr_accessor :customer_id
    attr_accessor :invoice_data
    attr_accessor :receiver
    attr_accessor :referred_code

    def set_invoice_data(value)
      self.invoice_data = build_value(InvoiceData, value)
    end

    def set_receiver(value)
      self.receiver = build_value(Receiver, value)
    end
  end
end
