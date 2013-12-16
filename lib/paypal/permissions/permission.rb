module PayPal::Permissions
  class Permission < PayPal::Permissions::Base

    attr_accessor :token
    attr_accessor :scope
    attr_accessor :callback

    def scope=(scopes)
      scopes = scopes.to_sym if scopes.is_a?(String)
      scopes = [scopes] if scopes.is_a?(Symbol)
      @scope = scopes.map{|scope| PayPal::Permissions::Request::SCOPE_TYPES[scope.to_sym] }.compact
    end

    def get_permission
      Response.process(:get_permissions, request.run(:get_permissions, self.to_hash(:token, :request_envelope)))
    end

    def request_permission
      response = Response.process(:request_permissions, request.run(:request_permissions, self.to_hash(:scope, :callback, :request_envelope)))
      self.token = response.token
      response
    end

    def cancel_permission
      Response.process(:cancel_permissions, request.run(:cancel_permissions, self.to_hash(:token, :request_envelope)))
    end

    def request_url
      "#{PayPal::Permissions::Api.site_endpoint}?cmd=_grant-permission&request_token=#{self.token}"
    end

  end
end
