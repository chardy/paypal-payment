module PayPal
  module ExpressCheckout
    module Response
      class TransactionDetails < Base
        has_fields :payment, :amount, :gift, :survey, :receiver, :payer, :ship_to, :auction, :subscription

        has_many :payment_items, :shipping_options
      end
    end
  end
end
