module PayPal::Permissions
  module Response
    require "paypal/permissions/response/personal_data"
    require "paypal/permissions/response/permission"
    require "paypal/permissions/response/token"

    RESPONDERS = {
      :cancel_permissions         => "Permission",
      :get_access_token           => "Token",
      :get_advance_personal_data  => "PersonalData",
      :get_basic_personal_data    => "PersonalData",
      :get_permissions            => "Permission",
      :request_permissions        => "Permission"
    }

    def self.process(method, response)
      response_class = PayPal::Permissions::Response.const_get(RESPONDERS[method])
      if response.respond_to?(:body_str)
        response_class.new(MultiJson.load(response.body_str))
      end
    # rescue
    end
  end
end