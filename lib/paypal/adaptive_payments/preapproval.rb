module PayPal::AdaptivePayments
  class Preapproval < PayPal::AdaptivePayments::Base

    attr_accessor :preapproval_key
    attr_accessor :client_details
    attr_accessor :cancel_url
    attr_accessor :currency_code
    attr_accessor :date_of_month
    attr_accessor :day_of_week
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
    attr_accessor :display_max_total_amount
    attr_accessor :fees_payer
    attr_accessor :require_instant_funding_source

    def set_client_details(value)
      self.client_details = build_value(ClientDetails, value)
    end

    def set_ending_date(value)
      self.ending_date = build_datetime(value)
    end

    def set_starting_date(value)
      self.starting_date = build_datetime(value)
    end

    def create
      response = Response.process(:preapproval, request.run(:preapproval, self.to_hash))
      self.preapproval_key = response.preapproval_key
      response
    end

    def details
      Response.process(:preapproval_details, request.run(:preapproval_details, self.to_hash(:preapproval_key)))
    end

    def cancel
      Response.process(:cancel_preapproval, request.run(:cancel_preapproval, self.to_hash(:preapproval_key)))
    end
  end
end