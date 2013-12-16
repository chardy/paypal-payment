module PayPal
  module ExpressCheckout
    module Response
      autoload :Base,                 "paypal/express_checkout/response/base"
      autoload :Address,              "paypal/express_checkout/response/address"
      autoload :Account,              "paypal/express_checkout/response/account"
      autoload :Authorization,        "paypal/express_checkout/response/authorization"
      autoload :Capture,              "paypal/express_checkout/response/capture"
      autoload :Checkout,             "paypal/express_checkout/response/checkout"
      autoload :Details,              "paypal/express_checkout/response/details"
      autoload :Payment,              "paypal/express_checkout/response/payment"
      autoload :TransactionDetails,   "paypal/express_checkout/response/transaction_details"
      autoload :ManageProfile,        "paypal/express_checkout/response/manage_profile"
      autoload :Profile,              "paypal/express_checkout/response/profile"
      autoload :Refund,               "paypal/express_checkout/response/refund"
      autoload :Reference,            "paypal/express_checkout/response/reference"
      autoload :Search,               "paypal/express_checkout/response/search"
      autoload :CallbackRequest,      "paypal/express_checkout/response/callback_request"
      autoload :CallbackResponse,     "paypal/express_checkout/response/callback_response"

      RESPONDERS = {
        :address_verify       => "Address",
        :balance              => "Account",
        :pal_details          => "Account",
        :authorize            => "Authorization",
        :reauthorize          => "Authorization",
        :void                 => "Authorization",
        :capture              => "Capture",
        :checkout             => "Checkout",
        :pay                  => "Checkout",
        :details              => "Details",
        :payment              => "Payment",
        :transaction_details  => "TransactionDetails",
        :update_status        => "Payment",
        :search               => "Search",
        :profile              => "Profile",
        :create_profile       => "ManageProfile",
        :manage_profile       => "ManageProfile",
        :update_profile       => "ManageProfile",
        :bill_outstanding     => "ManageProfile",
        :refund               => "Refund",
        :reference            => "Reference",
        :callback_response    => "CallbackResponse"
      }

      def self.process(method, response)
        response_class = PayPal::ExpressCheckout::Response.const_get(RESPONDERS[method])
        response_class.new(response)
      end
    end
  end
end
