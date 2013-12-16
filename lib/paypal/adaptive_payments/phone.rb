module PayPal::AdaptivePayments
  class Phone
    include PayPal::Common::Base

    attr_accessor :country_code
    attr_accessor :phone_number
    attr_accessor :extension
  end
end