module PayPal::Invoice
  class Base
    include PayPal::Common::Base

    attr_accessor :request_envelope

    def request
      PayPal::Invoice::Request.new
    end
  end
end