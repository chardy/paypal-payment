module PayPal::AdaptivePayments::Response
  class AddressList
    include PayPal::Common::Base

    attr_accessor :address

    def set_address(value)
      self.address = build_value(Address, value)
    end
  end
end