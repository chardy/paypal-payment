module PayPal::AdaptivePayments
  class InstitutionCustomer
    include PayPal::Common::Base

    attr_accessor :institution_id
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :display_name
    attr_accessor :institution_customer_id
    attr_accessor :county_code
    attr_accessor :email
  end
end
