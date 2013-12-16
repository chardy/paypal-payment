module PayPal::Invoice
  class Invoice < PayPal::Invoice::Base

    attr_accessor :merchant_email
    attr_accessor :payer_email
    attr_accessor :number
    attr_accessor :merchant_info
    attr_accessor :item_list
    attr_accessor :currency_code
    attr_accessor :invoice_date
    attr_accessor :due_date
    attr_accessor :payment_terms
    attr_accessor :discount_percent
    attr_accessor :discount_amount
    attr_accessor :terms
    attr_accessor :note
    attr_accessor :merchant_memo
    attr_accessor :billing_info
    attr_accessor :shipping_info
    attr_accessor :shipping_amount
    attr_accessor :shipping_tax_name
    attr_accessor :shipping_tax_rate
    attr_accessor :logo_url
    attr_accessor :referrer_code
    attr_accessor :invoice_id
    attr_accessor :subject
    attr_accessor :note_for_payer
    attr_accessor :send_copy_to_mechant

    # mark_as_paid attribtues
    attr_accessor :payment

    # mark_as_refunded attribute
    attr_accessor :refund_detail

    attr_accessor :response

    def hash_keys
      {
        :invoice_id => :invoiceID
      }
    end

    def set_merchant_info(value)
      self.merchant_info = build_value(BusinessInfo, value)
    end

    def set_billing_info(value)
      self.billing_info = build_value(BusinessInfo, value)
    end

    def set_shipping_info(value)
      self.shipping_info = build_value(BusinessInfo, value)
    end

    def set_item_list(value)
      self.item_list = build_value(InvoiceItemList, value)
    end

    def set_invoice_date(value)
      self.invoice_date = build_datetime(value)
    end

    def set_due_date(value)
      self.due_date = build_datetime(value)
    end

    def set_payment(value)
      self.payment = build_value(OtherPaymentDetails, value)
    end

    def set_refund_detail(value)
      self.refund_detail = build_value(OtherPaymentDetails, value)
    end

    def create
      self.response = Response.process(:create, request.run(:create, { :invoice => self.to_hash }))
      self.invoice_id = self.response.invoice_id
      self.response
    end

    def send_invoice
      self.response = Response.process(:send, request.run(:send, self.to_hash(:invoice_id)))
    end

    def create_and_send
      self.response = Response.process(:create_and_send, request.run(:create_and_send, { :invoice => self.to_hash }))
      self.invoice_id = self.response.invoice_id
      self.response
    end

    def update
      self.response = Response.process(:update, request.run(:update, { :invoiceID => self.invoice_id, :invoice => self.to_hash}))
    end

    def cancel
      self.response = Response.process(:cancel, request.run(:cancel, self.to_hash(:invoice_id)))
    end

    def details
      self.response = Response.process(:details, request.run(:details, self.to_hash(:invoice_id)))
    end

    def mark_as_paid
      self.response = Response.process(:mark_as_paid, request.run(:mark_as_paid, self.to_hash(:invoice_id, :payment)))
    end

    def mark_as_unpaid
      self.response = Response.process(:mark_as_unpaid, request.run(:mark_as_unpaid, self.to_hash(:invoice_id)))
    end

    def mark_as_refunded
      self.response = Response.process(:mark_as_refunded, request.run(:mark_as_refunded, self.to_hash(:invoice_id, :refund_detail)))
    end

  end
end