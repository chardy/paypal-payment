module PayPal::Invoice::Response
  class Details
    include PayPal::Common::Response

    attr_accessor :invoice_id
    attr_accessor :invoice
    attr_accessor :invoice_details
    attr_accessor :payment_details
    attr_accessor :invoice_url

    def set_invoice(value)
      self.invoice = build_value(Invoice, value)
    end

    def set_invoice_details(value)
      self.invoice_details = build_value(InvoiceDetails, value)
    end

    def set_payment_details(value)
      self.payment_details = build_value(PaymentDetails, value)
    end
  end
end