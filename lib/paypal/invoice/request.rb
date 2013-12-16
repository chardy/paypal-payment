module PayPal::Invoice
  class Request < PayPal::Common::Request

    METHODS = {
      :create           => 'CreateInvoice',
      :send             => 'SendInvoice',
      :create_and_send  => 'CreateAndSendInvoice',
      :update           => 'UpdateInvoice',
      :details          => 'GetInvoiceDetails',
      :cancel           => 'CancelInvoice',
      :search           => 'SearchInvoices',
      :mark_as_paid     => 'MarkInvoiceAsPaid',
      :mark_as_unpaid   => 'MarkInvoiceAsUnpaid',
      :mark_as_refunded => 'MarkInvoiceAsRefunded'
    }

    PAYMENT_TERMS = {
      :due_on_receipt         => 'DueOnReceipt',
      :due_on_date_specified  => 'DueOnDateSpecified',
      :net10                  => 'Net10',
      :net15                  => 'Net15',
      :net30                  => 'Net30',
      :net45                  => 'Net45'
    }

    FEE_PAYERS = {
      :sender           => 'SENDER',
      :primary_receiver => 'PRIMARYRECEIVER',
      :each_receiver    => 'EACHRECEIVER',
      :secondary_only   => 'SECONDARYONLY'
    }

    def api
      PayPal::Invoice::Api
    end

    # Returns the actual api endpoint base on method
    #
    def method_endpoint(method)
      "#{api.api_endpoint}/#{METHODS.fetch(method, method.to_s)}"
    end
  end
end