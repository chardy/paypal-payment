module PayPal
  module ExpressCheckout
    module Response
      class Authorization < Base
        has_fields :payment, :amount

        # mapping(
        #   :authorization_id             => :AUTHORIZATIONID,
        #   :transaction_id               => :TRANSACTIONID,
        #   :amount                       => :AMT,
        #   :msg_sub_id                   => :MSGSUBID,
        #   :payment_status               => :PAYMENTSTATUS,
        #   :pending_reason               => :PENDINGREASON,
        #   :protection_eligibility       => :PROTECTIONELIGIBILITY,
        #   :protection_eligibility_type  => :PROTECTIONELIGIBILITYTYPE
        # )

        def pending?
          payment_status == 'Pending'
        end

      end
    end
  end
end
