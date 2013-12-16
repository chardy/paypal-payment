module PayPal::AdaptivePayments
  class Payment < PayPal::AdaptivePayments::Base

    attr_accessor :action_type
    attr_accessor :cancel_url
    attr_accessor :client_details
    attr_accessor :currency_code
    attr_accessor :fees_payer
    attr_accessor :funding_constraint
    attr_accessor :ipn_notification_url
    attr_accessor :memo
    attr_accessor :pay_key
    attr_accessor :pin
    attr_accessor :preapproval_key
    attr_accessor :receiver_list
    attr_accessor :return_url
    attr_accessor :reverse_all_parallel_payments_on_error
    attr_accessor :sender
    attr_accessor :sender_email
    attr_accessor :tracking_id
    attr_accessor :transaction_id

    attr_accessor :payment_info_list

    attr_accessor :response

    def pay_key=(key)
      @pay_key = key
      @key = key
    end

    def receiver=(receiver)
      self.receiver_list.only(receiver)
    end

    def receiver
      self.receiver_list.first
    end

    def receiver_list
      @receiver_list ||= ReceiverList.new
    end

    def create
      self.action_type = 'CREATE'
      run_pay
    end

    def pay
      if self.pay_key
        run_execute
      else
        self.action_type = 'PAY'
        run_pay
      end
    end

    def pay_primary
      self.action_type = 'PAY_PRIMARY'
      run_pay
    end

    def details
      Response.process(:payment_details, request.run(:payment_details, self.to_hash(:pay_key, :transaction_id, :tracking_id)))
    end

    def shipping_addresses
      Response.process(:shipping_addresses, request.run(:shipping_addresses, self.to_hash(:key)))
    end

    def refund
      Response.process(:refund, request.run(:refund, self.to_hash))
    end

    def run_execute
      Response.process(:execute_payment, request.run(:execute_payment, self.to_hash(:pay_key)))
    end

    def run_pay
      self.response = Response.process(:pay, request.run(:pay, self.to_hash))
      self.pay_key = self.response.pay_key
      self.response
    end

    def payment_url
      self.response && self.response.payment_url
    end

    def set_funding_constraint(value)
      self.funding_constraint = build_value(FundingConstraint, value)
    end

    def set_payment_info_list(value)
      self.payment_info_list = build_value(PaymentInfoList, value)
    end

    def set_sender(value)
      self.sender = build_value(SenderIdentifier, value)
    end

    def set_receiver(value)
      self.receiver = build_value(Receiver, value)
    end
  end
end
