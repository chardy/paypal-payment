module PayPal::AdaptivePayments::Response
  class PayError
    include PayPal::Common::Base

    attr_accessor :error
    attr_accessor :receiver

    def set_error(value)
      self.error = build_value(ErrorData, value)
    end

    def set_receiver(value)
      self.receiver = build_value(Receiver, value)
    end
  end
end