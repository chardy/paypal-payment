module PayPal
  module ExpressCheckout
    module Response
      class Details < Base
        has_fields :checkout, :giro, :gift, :survey, :buyer, :tax, :payer

        has_many :payments

        def payment
          @payment ||= payments.first
        end

        def notify_url
          payment && payment.notify_url
        end

        def amount
          payment && payment.amount
        end

        def description
          payment && payment.description
        end

        def currency
          payment && payment.currency
        end

        def agreed?
          params["BILLINGAGREEMENTACCEPTEDSTATUS"] == "1"
        end
      end
    end
  end
end
