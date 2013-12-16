module PayPal::Permissions::Response
  class Token
    include PayPal::Common::Response

    attr_accessor :scope
    attr_accessor :token
    attr_accessor :token_secret

  end
end