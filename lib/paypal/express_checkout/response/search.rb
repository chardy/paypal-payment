module PayPal
  module ExpressCheckout
    module Response
      class Search < PayPal::ExpressCheckout::Response::Base

        def payments
          @payments ||= begin
            index = 0
            [].tap do |payments|
              while params["L_TIMESTAMP#{index}"]
                payments << PayPal::ExpressCheckout::Payment.new({
                  :timestamp          => params["L_TIMESTAMP#{index}"],
                  :time_zone          => params["L_TIMEZONE#{index}"],
                  :payment_type       => params["L_TYPE#{index}"],
                  :email              => params["L_EMAIL#{index}"],
                  :name               => params["L_NAME#{index}"],
                  :transaction_id     => params["L_TRANSACTIONID#{index}"],
                  :status             => params["L_STATUS#{index}"],
                  :amount             => params["L_AMT#{index}"].to_f,
                  :currency           => params["L_CURRENCYCODE#{index}"],
                  :fee_amount         => params["L_FEEAMT#{index}"].to_f,
                  :net_amount         => params["L_NETAMT#{index}"].to_f
                })

                index += 1
              end
            end
          end
        end
      end
    end
  end
end