module PayPal::Invoice
  class BusinessInfo < PayPal::Invoice::Base

    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :business_name
    attr_accessor :phone
    attr_accessor :fax
    attr_accessor :website
    attr_accessor :custom_value
    attr_accessor :address

    def set_address(value)
      self.address = build_value(BaseAddress, value)
    end
  end
end