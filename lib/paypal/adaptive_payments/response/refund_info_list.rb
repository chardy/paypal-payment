module PayPal::AdaptivePayments::Response
  class RefundInfoList
    include PayPal::Common::Base

    attr_accessor :refund_info

    def set_refund_info(value)
      self.refund_info = build_value(RefundInfo, value)
    end
  end
end