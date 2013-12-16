module PayPal::Invoice
  class DateRange < PayPal::Invoice::Base

    attr_accessor :start_date
    attr_accessor :end_date

  end
end