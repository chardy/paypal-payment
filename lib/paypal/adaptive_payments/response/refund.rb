module PayPal::AdaptivePayments::Response
  class Refund
    include PayPal::Common::Response

    attr_accessor :currency_code
    attr_accessor :refund_info_list

    def set_refund_info_list(value)
      self.refund_info_list = build_value(RefundInfoList, value)
    end

    def refund_infos
      (self.refund_info_list && self.refund_info_list.refund_info) || []
    end
  end
end