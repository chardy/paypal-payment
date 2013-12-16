module PayPal::AdaptivePayments::Response
  class Pay
    include PayPal::Common::Response

    attr_accessor :pay_key
    attr_accessor :pay_error_list
    attr_accessor :payment_exec_status
    attr_accessor :default_funding_plan
    attr_accessor :warning_data_list

    def set_pay_error_list(value)
      self.pay_error_list = build_value(PayErrorList, value)
    end

    def pay_errors
      (self.pay_error_list && self.pay_error_list.errors) || []
    end

    def errors
      super + pay_errors
    end

    def payment_url
      "#{PayPal::Api.site_endpoint}?cmd=_ap-payment&paykey=#{self.pay_key}"
    end

    def completed?
      self.payment_exec_status == 'COMPLETED'
    end
  end
end