module PayPal::AdaptivePayments
  class InvoiceData
    include PayPal::Common::Base

    attr_accessor :item
    attr_accessor :total_tax
    attr_accessor :total_shipping

    def set_item(value)
      self.item = build_value(InvoiceItem, value)
    end
  end
end
