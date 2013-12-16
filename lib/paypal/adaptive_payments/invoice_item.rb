module PayPal::AdaptivePayments
  class InvoiceItem
    include PayPal::Common::Base

    attr_accessor :name
    attr_accessor :identifier
    attr_accessor :price
    attr_accessor :item_price
    attr_accessor :item_count
  end
end
