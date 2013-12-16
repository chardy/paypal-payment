module PayPal::AdaptivePayments::Response
  class ShippingAddress
    include PayPal::Common::Response

    attr_accessor :selectedAddress

    def set_selected_address(value)
      self.selected_address = build_value(Address, value)
    end
  end
end