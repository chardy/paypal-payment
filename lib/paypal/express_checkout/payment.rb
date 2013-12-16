module PayPal
  module ExpressCheckout
    class Payment < PayPal::ExpressCheckout::Base
      has_fields :payment, :ship_to, :amount, :payment_items, :credit_card, :payer, :address, :search, :refund, :seller

      has_many :payment_items

      def search
        params = collect(
          :start_date,
          :end_date,
          :amount,
          :currency,
          :email,
          :receiver,
          :receipt_id,
          :account,
          :invoice_num,
          :transaction_id,
          :transaction_class,
          :auction_item_num,
          :status,
          :profile_id,
          :salutation,
          :first_name,
          :middle_name,
          :last_name,
          :suffix
        )

        run(:search, params)
      end

      def update_status
        params = collect(
          :transaction_id,
          :action
        )

        run(:update_status, params)
      end

      def refund
        params = group_collect(
          :transaction_id,
          :amount,
          :refund,
          :msg_sub_id,
          :store_id,
          :terminal_id
        )

        run(:refund, params)
      end

      def reference
        params = group_collect(
          :payment,
          :ship_to,
          :amount,
          :payment_items,
          :credit_card,
          :payer,
          :address
        )

        run(:reference, params)
      end

      def details
        params = collect(:transaction_id)
        run(:transaction_details, params)
      end
    end
  end
end