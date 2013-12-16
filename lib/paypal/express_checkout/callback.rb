module PayPal
  module ExpressCheckout
    class Callback < PayPal::ExpressCheckout::Base
      has_fields :callback
      has_many :shipping_options

      def response
        params = group_collect(
          :callback,
          :shipping_options
        )

        run(:callback_response, params)
      end
    end
  end
end