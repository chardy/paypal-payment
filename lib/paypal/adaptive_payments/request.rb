module PayPal::AdaptivePayments
  class Request < PayPal::Common::Request

    METHODS = {
      :cancel_preapproval   => 'CancelPreapproval',
      :convert_currency     => 'ConvertCurrency',
      :execute_payment      => 'ExecutePayment',
      :funding_plans        => 'GetFundingPlans',
      :get_payment_options  => 'GetPaymentOptions',
      :shipping_addresses   => 'GetShippingAddresses',
      :pay                  => 'Pay',
      :payment_details      => 'PaymentDetails',
      :preapproval          => 'Preapproval',
      :preapproval_details  => 'PreapprovalDetails',
      :refund               => 'Refund',
      :set_payment_options  => 'SetPaymentOptions'
    }

    ACTION_TYPES = {
      :pay          => 'PAY',
      :create       => 'CREATE',
      :pay_primary  => 'PAY_PRIMARY'
    }

    PAYMENT_TYPES = {
      :goods                    => 'GOODS',
      :service                  => 'SERVICE',
      :personal                 => 'PERSONAL',
      :cash_advance             => 'CASHADVANCE',
      :digital_goods            => 'DIGITALGOODS',
      :bank_managed_withdrawal  => 'BANK_MANAGED_WITHDRAWAL'
    }

    FEE_PAYERS = {
      :sender           => 'SENDER',
      :primary_receiver => 'PRIMARYRECEIVER',
      :each_receiver    => 'EACHRECEIVER',
      :secondary_only   => 'SECONDARYONLY'
    }

    def api
      PayPal::AdaptivePayments::Api
    end

    # Returns the actual api endpoint base on method
    #
    def method_endpoint(method)
      "#{api.api_endpoint}/#{METHODS.fetch(method, method.to_s)}"
    end
  end
end