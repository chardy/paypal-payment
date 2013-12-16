module PayPal::AdaptivePayments
  class PaymentOptions < PayPal::AdaptivePayments::Base

    attr_accessor :pay_key
    attr_accessor :display_options
    attr_accessor :initiating_entity
    attr_accessor :shipping_address_id
    attr_accessor :sender_options
    attr_accessor :receiver_options

    def self.find(key)
      self.new(:pay_key => key).get
    end

    def get
      Response.process(:get_payment_options, request.run(:get_payment_options, self.to_hash))
    end

    def set
      Response.process(:set_payment_options, request.run(:set_payment_options, self.to_hash))
    end

    def set_display_options(value)
      self.display_options = build_value(DisplayOptions, value)
    end

    def set_initiating_entity(value)
      self.initiating_entity = build_value(InitiatingEntity, value)
    end

    def set_sender_options(value)
      self.sender_options = build_value(SenderOptions, value)
    end

    def set_receiver_options(value)
      self.receiver_options = build_value(ReceiverOptions, value)
    end
  end
end