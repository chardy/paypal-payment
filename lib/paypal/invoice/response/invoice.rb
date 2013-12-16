module PayPal::Invoice::Response
  class Invoice
    include PayPal::Common::Response

    attr_accessor :invoice_id
    attr_accessor :invoice_number
    attr_accessor :invoice_url
    attr_accessor :total_amount
  end
end