module PayPal::Permissions
  class PersonalData < PayPal::Permissions::Base

    attr_accessor :token
    attr_accessor :scope
    attr_accessor :callback

    def advance
      Response.process(:get_advance_personal_data, request.run(:get_advance_personal_data, self.to_hash(:token)))
    end

    def basic
      Response.process(:get_basic_personal_data, request.run(:get_basic_personal_data, self.to_hash(:token)))
    end

  end
end
