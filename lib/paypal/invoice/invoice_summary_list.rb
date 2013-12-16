module PayPal::Invoice
  class InvoiceSummaryList < PayPal::Invoice::Base

    attr_accessor :invoice

    def set_invoice(value)
      self.invoice = build_value(InvoiceSummary, value)
    end
  end
end