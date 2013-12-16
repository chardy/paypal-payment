module PayPal::AdaptivePayments::Response
  class ErrorList
    include PayPal::Common::Base

    attr_accessor :error

    def set_error(value)
      self.error = build_value(ErrorData, value)
    end

    def errors
      self.error
    end
  end
end