module PayPal::Invoice::Response
  class Search
    include PayPal::Common::Response

    attr_accessor :count
    attr_accessor :invoice_list
    attr_accessor :page
    attr_accessor :has_next_page
    attr_accessor :has_previous_page

    def set_invoice_list(value)
      self.invoice_list = build_value(InvoiceSummaryList, value)
    end
  end
end