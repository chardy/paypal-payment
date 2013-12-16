module PayPal::AdaptivePayments::Response
  class RefundInfo
    include PayPal::Common::Base

    attr_accessor :receiver
    attr_accessor :refund_status
    attr_accessor :refund_net_amount
    attr_accessor :refund_fee_amount
    attr_accessor :refund_gross_amount
    attr_accessor :total_of_all_refunds
    attr_accessor :refund_has_become_full
    attr_accessor :encrypted_refund_transaction_id
    attr_accessor :refund_transaction_status
    attr_accessor :error_list

    def set_receiver(value)
      self.receiver = build_value(Receiver, value)
    end

    def errors
      self.error_list.error
    end
  end
end