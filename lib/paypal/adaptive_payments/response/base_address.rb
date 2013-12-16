module PayPal::AdaptivePayments::Response
  class BaseAddress
    include PayPal::Common::Base

    attr_accessor :line1
    attr_accessor :line2
    attr_accessor :city
    attr_accessor :state
    attr_accessor :postal_code
    attr_accessor :country_code
    attr_accessor :type
  end
end