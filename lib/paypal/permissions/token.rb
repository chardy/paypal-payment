module PayPal::Permissions
  class Token < PayPal::Permissions::Base

    attr_accessor :token
    attr_accessor :verifier
    attr_accessor :subject_alias

    def access_token
      Response.process(:get_access_token, request.run(:get_access_token, self.to_hash(:token, :verifier, :subject_alias, :request_envelope)))
    end

  end
end
