# include PayPal::AdaptivePayments::Response

module PayPal::AdaptivePayments::Response
  class Details < PayPal::AdaptivePayments::Payment
    include PayPal::Common::Response

    def payment_info
      @payment_info ||= (payment_info_list && payment_info_list.payment_info) || []
    end

    def receivers
      @receivers ||= payment_info.map { |pi| pi.receiver }
    end

    def receiver
      @receiver ||= receivers.first
    end
  end
end