module PayPal
  module ExpressCheckout
    module Response
      class Account < PayPal::ExpressCheckout::Response::Base

        has_fields :account
        # mapping(
        #   :pal                => :PAL,
        #   :locale             => :LOCALE
        # )

        def balances
          @balances ||= begin
            index = 0
            [].tap do |balances|
              while params["L_AMT#{index}"]
                balances << {
                  :amount => params["L_AMT#{index}"].to_f,
                  :currency => params["L_CURRENCYCODE#{index}"]
                }

                index += 1
              end
            end
          end
        end
      end
    end
  end
end
