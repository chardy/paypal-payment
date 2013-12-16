module PayPal::AdaptivePayments
  module Response
    require "paypal/adaptive_payments/response/pay"
    require "paypal/adaptive_payments/response/pay_error_list"
    require "paypal/adaptive_payments/response/pay_error"
    require "paypal/adaptive_payments/response/preapproval"
    require "paypal/adaptive_payments/response/address_list"
    require "paypal/adaptive_payments/response/base_address"
    require "paypal/adaptive_payments/response/address"
    require "paypal/adaptive_payments/response/shipping_address"
    require "paypal/adaptive_payments/response/error_list"
    require "paypal/adaptive_payments/response/refund_info"
    require "paypal/adaptive_payments/response/refund_info_list"
    require "paypal/adaptive_payments/response/refund"
    require "paypal/adaptive_payments/response/base_address"

    RESPONDERS = {
      :pay                  => "Pay",
      :execute_payment      => "Pay",
      :payment_details      => "Details",
      :get_payment_options  => "PayOptions",
      :set_payment_options  => "PayOptions",
      :preapproval          => "Preapproval",
      :preapproval_details  => "Preapproval",
      :cancel_preapproval   => "Preapproval",
      :refund               => "Refund",
      :shipping_addresses   => "ShippingAddress"
    }

    def self.process(method, response)
      response_class = PayPal::AdaptivePayments::Response.const_get(RESPONDERS[method])
      if response.respond_to?(:body_str)
        response_class.new(MultiJson.load(response.body_str))
      end
    # rescue
    end
  end
end