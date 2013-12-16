module PayPal::Invoice
  class SearchParameters < PayPal::Invoice::Base

    attr_accessor :email
    attr_accessor :recipient_name
    attr_accessor :business_name
    attr_accessor :invoice_number
    attr_accessor :status
    attr_accessor :lower_amount
    attr_accessor :upper_amount
    attr_accessor :currency_code
    attr_accessor :memo
    attr_accessor :origin
    attr_accessor :invoice_date
    attr_accessor :due_date
    attr_accessor :payment_date
    attr_accessor :creation_date

  end
end