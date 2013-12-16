module PayPal::Invoice
  class PayPalPaymentDetails < PayPal::Invoice::Base

    attr_accessor :transaction_id
    attr_accessor :date

    def set_date(value)
      self.date = build_datetime(value)
    end
  end
end