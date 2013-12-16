module PayPal
  module ExpressCheckout
    class Checkout < PayPal::ExpressCheckout::Base
      has_fields :checkout, :giro, :gift, :survey, :buyer, :tax, :shipping_option, :landing_page, :solution_type, :channel_type

      has_many :shipping_options, :payments, :billings

      # Request a checkout token.
      #
      #   ppr = PayPal::ExpressCheckout::Checkout.new({
      #     :return_url         => "http://example.com/checkout/thank_you",
      #     :cancel_url         => "http://example.com/checkout/canceled",
      #     :ipn_url            => "http://example.com/paypal/ipn",
      #     :description        => "Awesome - Monthly Subscription",
      #     :amount             => "9.00",
      #     :currency           => "USD"
      #   })
      #
      #   response = ppr.request_token
      #   response.checkout_url
      #
      def checkout
        params = group_collect(
          :checkout,
          :giro,
          :gift,
          :survey,
          :buyer,
          :tax,
          :landing_page, 
          :solution_type, 
          :channel_type,
          :payments,
          :shipping_options,
          :billings
        )

        run(:checkout, params)
      end

      # Return checkout details.
      #
      #   ppr = PayPal::ExpressCheckout::Checkout.new({
      #     :token => "EC-6LX60229XS426623E"
      #   })
      #   response = ppr.details
      #
      def details
        run(:details, :token => token)
      end

      # Verify an address.
      #   ppr = PayPal::ExpressCheckout::Checkout.new({
      #     :email  => "user@example.com",
      #     :street => "ABCEDFGH",
      #     :zip    => "1234"
      #   })
      #   response = ppr.refund
      #
      def address_verify
        params = collect(
          :email,
          :street,
          :zip
        )

        run(:address_verify, params)
      end

      # Execute payment. DoExpressCheckoutPayment
      def pay
        params = group_collect(
          :token,
          :payer_id,
          :return_fmf_details,
          :payments,
          :survey,
          :shipping_option
        )

        run(:pay, params)
      end

      # Do authorization
      #
      def authorize
        params = collect(
          :transaction_id,
          :amount,
          :transaction_entity,
          :currency,
          :msg_sub_id
        )

        run(:authorize, params)
      end

      # Do authorization
      #
      def reauthorize
        params = collect(
          :transaction_id,
          :amount,
          :transaction_entity,
          :currency,
          :msg_sub_id
        )

        run(:reauthorize, params)
      end

      # Do capture
      #
      def capture
        params = collect(
          :authorization_id,
          :amount,
          :currency,
          :complete_type,
          :invoice_no,
          :note,
          :soft_descriptor,
          :msg_sub_id,
          :store_id,
          :terminal_id
        )

        run(:capture, params)
      end

      # Do void
      #
      def void
        params = collect(
          :authorization_id,
          :note,
          :msg_sub_id
        )

        run(:void, params)
      end
    end
  end
end