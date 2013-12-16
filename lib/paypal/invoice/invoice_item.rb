module PayPal::Invoice
  class InvoiceItem < PayPal::Invoice::Base

    attr_accessor :name
    attr_accessor :description
    attr_accessor :date
    attr_accessor :quantity
    attr_accessor :unit_price
    attr_accessor :tax_name
    attr_accessor :tax_rate

  end
end