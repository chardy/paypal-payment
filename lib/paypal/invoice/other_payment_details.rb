module PayPal::Invoice
  class OtherPaymentDetails < PayPal::Invoice::Base

    attr_accessor :method
    attr_accessor :note
    attr_accessor :date

    def set_date(value)
      self.date = build_datetime(value)
    end

  end
end