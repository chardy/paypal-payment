module PayPal
  module ExpressCheckout
    module Response
      class Profile < PayPal::ExpressCheckout::Response::Base
        has_fields :recurring, :amount, :ship_to, :credit_card, :payer, :address

        OUTSTANDING = {
          "AddToNextBilling"    => :next_billing,
          "NoAutoBill"          => :no_auto_bill
        }

        STATUS = {
          "Cancelled"           => :cancelled,
          "Active"              => :active,
          "Suspended"           => :suspended
        }

        PERIOD = {
          "Month"               => :monthly,
          "Weekly"              => :weekly,
          "Year"                => :yearly,
          "Day"                 => :daily
        }

        def active?
          status == :active
        end

        def build_auto_bill_outstanding(value)
          OUTSTANDING.fetch(value, value)
        end

        def build_status(value)
          STATUS.fetch(value, value)
        end

        def build_date(string)
          Time.parse(string)
        end

        def build_start_at(string)
          Time.parse(string)
        end

        def build_last_payment_date(string)
          Time.parse(string)
        end

        def build_period(value)
          PERIOD.fetch(value, value)
        end

        alias_method :build_start_at, :build_date
        alias_method :build_last_payment_date, :build_date
      end
    end
  end
end
