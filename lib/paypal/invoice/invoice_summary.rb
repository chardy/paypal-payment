module PayPal::Invoice
  class InvoiceSummary < PayPal::Invoice::Base

    attr_accessor :invoice_id
    attr_accessor :merchant_email
    attr_accessor :payer_email
    attr_accessor :number
    attr_accessor :currency_code
    attr_accessor :billing_business_name
    attr_accessor :billing_first_name
    attr_accessor :billing_last_name
    attr_accessor :shipping_business_name
    attr_accessor :shipping_first_name
    attr_accessor :shipping_last_name
    attr_accessor :total_amount
    attr_accessor :invoice_date
    attr_accessor :due_date
    attr_accessor :status
    attr_accessor :origin

  end
end