module PayPal::Permissions::Response
  class PersonalData
    include PayPal::Common::Response

    attr_accessor :personal_data
    
  end
end