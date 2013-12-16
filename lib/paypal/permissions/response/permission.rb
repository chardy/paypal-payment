module PayPal::Permissions::Response
  class Permission
    include PayPal::Common::Response

    attr_accessor :token
    attr_accessor :scope
    attr_accessor :response_envelope

    def request_url
      "#{PayPal::Permissions::Api.site_endpoint}?cmd=_grant-permission&request_token=#{self.token}"
    end

  end
end