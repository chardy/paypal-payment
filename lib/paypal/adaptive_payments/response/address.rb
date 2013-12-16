module PayPal::AdaptivePayments::Response
  class Address
    include PayPal::Common::Base

    attr_accessor :address_name
    attr_accessor :base_address
    attr_accessor :address_id

    def set_base_address(value)
      self.base_address = build_value(BaseAddress, value)
    end
  end
end