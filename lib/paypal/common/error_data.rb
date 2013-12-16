module PayPal::Common
  class ErrorData
    include PayPal::Common::Base

    attr_accessor :category
    attr_accessor :domain
    attr_accessor :error_id
    attr_accessor :exception_id
    attr_accessor :message
    attr_accessor :parameter
    attr_accessor :severity
    attr_accessor :subdomain

  end
end