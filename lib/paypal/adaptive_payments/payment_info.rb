module PayPal::AdaptivePayments
  class PaymentInfo
    include PayPal::Common::Base

    attr_accessor :transaction_id
    attr_accessor :transaction_status
    attr_accessor :receiver
    attr_accessor :refunded_amount
    attr_accessor :pending_refund
    attr_accessor :sender_transaction_id
    attr_accessor :sender_transaction_status
    attr_accessor :pending_reason

    def set_receiver(value)
      self.receiver = build_value(Receiver, value)
    end
  end
end
