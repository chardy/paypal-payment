module PayPal::AdaptivePayments
  class InitiatingEntity
    include PayPal::Common::Base

    attr_accessor :institution_customer

    def set_institution_customer(value)
      self.institution_customer = build_value(InstitutionCustomer, value)
    end
  end
end
