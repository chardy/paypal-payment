module PayPal
  module ExpressCheckout
    class Account < PayPal::ExpressCheckout::Base
      has_fields :account

      def pal_details
        run(:pal_details)
      end

      def balance
        params = collect(:all_currencies)
        run(:balance, params)
      end
    end
  end
end