module PayPal::Permissions
  class Base
    include PayPal::Common::Base

    attr_accessor :request_envelope

    def request
      PayPal::Permissions::Request.new
    end
  end
end