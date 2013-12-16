module PayPal::AdaptivePayments::Response
  class Preapproval
    include PayPal::Common::Response

    attr_accessor :preapproval_key
    attr_accessor :approved
    attr_accessor :cancel_url
    attr_accessor :cur_payments
    attr_accessor :cur_payments_amount
    attr_accessor :currency_code
    attr_accessor :date_of_month
    attr_accessor :day_of_week
    attr_accessor :ending_date
    attr_accessor :ending_date
    attr_accessor :max_amount_per_payment
    attr_accessor :max_number_of_payments
    attr_accessor :max_number_of_payments_per_period
    attr_accessor :max_total_amount_of_all_payments
    attr_accessor :payment_period
    attr_accessor :return_url
    attr_accessor :memo
    attr_accessor :ipn_notification_url
    attr_accessor :sender_email
    attr_accessor :starting_date
    attr_accessor :pin_type
    attr_accessor :address_list
    attr_accessor :fees_payer
    attr_accessor :require_instant_funding_source
    attr_accessor :status

    def set_address_list(value)
      self.address_list = build_value(AddressList, value)
    end

    def set_ending_date(value)
      self.ending_date = build_datetime(value)
    end

    def set_starting_date(value)
      self.starting_date = build_datetime(value)
    end

    def preapproval_url
      "#{PayPal::Api.site_endpoint}?cmd=_ap-preapproval&preapprovalkey=#{self.preapproval_key}"
    end
  end
end