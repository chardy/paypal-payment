module PayPal
  module ExpressCheckout
    class Recurring < PayPal::ExpressCheckout::Base
      has_fields :recurring, :ship_to, :credit_card, :payer, :address, :refund

      has_many   :payment_items

      # Suspend a recurring profile.
      # Suspended profiles can be reactivated.
      #
      #   ppr = PayPal::Recurring.new(:profile_id => "I-HYRKXBMNLFSK")
      #   response = ppr.suspend
      #
      def suspend
        run(:manage_profile, :action => :suspend, :profile_id => profile_id)
      end

      # Reactivate a suspended recurring profile.
      #
      #   ppr = PayPal::Recurring.new(:profile_id => "I-HYRKXBMNLFSK")
      #   response = ppr.reactivate
      #
      def reactivate
        run(:manage_profile, :action => :reactivate, :profile_id => profile_id)
      end

      # Cancel a recurring profile.
      # Cancelled profiles cannot be reactivated.
      #
      #   ppr = PayPal::Recurring.new(:profile_id => "I-HYRKXBMNLFSK")
      #   response = ppr.cancel
      #
      def cancel
        run(:manage_profile, :action => :cancel, :profile_id => profile_id)
      end

      # Create a recurring billing profile.
      #
      #   ppr = PayPal::ExpressCheckout::Recurring.new({
      #     :amount                => "9.00",
      #     :initial_amount        => "9.00",
      #     :initial_amount_action => :cancel,
      #     :currency              => "USD",
      #     :description           => "Awesome - Monthly Subscription",
      #     :ipn_url               => "http://example.com/paypal/ipn",
      #     :frequency             => 1,
      #     :token                 => "EC-05C46042TU8306821",
      #     :period                => :monthly,
      #     :reference             => "1234",
      #     :payer_id              => "WTTS5KC2T46YU",
      #     :start_at              => Time.now,
      #     :failed                => 1,
      #     :outstanding           => :next_billing,
      #     :trial_period          => :monthly,
      #     :trial_length          => 1,
      #     :trial_frequency       => 1,
      #     :trial_amount          => 0.00
      #   })
      #
      #   response = ppr.create_recurring_profile
      #
      def create_profile
        params = group_collect(
          :payment_items,
          :recurring,
          :payer
        )

        run(:create_profile, params)
      end

      # Update a recurring billing profile.
      #
      #   ppr = PayPal::ExpressCheckout::Recurring.new({
      #     :amount                => "99.00",
      #     :currency              => "USD",
      #     :description           => "Awesome - Monthly Subscription",
      #     :note                  => "Changed plan to Gold",
      #     :ipn_url               => "http://example.com/paypal/ipn",
      #     :reference             => "1234",
      #     :profile_id            => "I-VCEL6TRG35CU",
      #     :start_at              => Time.now,
      #     :outstanding           => :next_billing
      #   })
      #
      #   response = ppr.update_recurring_profile
      #
      def update_profile
        params = group_collect(
          :recurring,
          :credit_card,
          :payer,
          :address
        )

        run(:update_profile, params)
      end

      # Retrieve information about existing recurring profile.
      #
      #   ppr = PayPal::ExpressCheckout::Recurring.new(:profile_id => "I-VCEL6TRG35CU")
      #   response = ppr.profile
      #
      def profile
        run(:profile, :profile_id => profile_id)
      end

      def bill_outstanding
        params = collect(
          :profile_id,
          :amount,
          :note
        )

        run(:bill_outstanding, params)
      end

      # Retrive fixed options specific request action

      # def fixed_options(request_action)
      #   {
      #     :checkout => {
      #       :payment_action => "Authorization",
      #       :no_shipping => 1,
      #       :L_BILLINGTYPE0 => "RecurringPayments"
      #     }
      #   }.fetch(request_action, {})
      # end
    end
  end
end