module PayPal::Invoice
  class InvoiceItemList < PayPal::Invoice::Base

    attr_accessor :item

    def set_item(value)
      self.item = build_value(InvoiceItem, value)
    end
  end
end