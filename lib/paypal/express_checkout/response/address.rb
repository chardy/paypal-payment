module PayPal
  module ExpressCheckout
    module Response
      class Address < PayPal::ExpressCheckout::Response::Base

        has_fields :address
        # mapping(
        #   :confirmation => :CONFIRMATIONCODE,
        #   :street_match => :STREETMATCH,
        #   :zip_match    => :ZIPMATCH,
        #   :country      => :COUNTRYCODE
        #   :token        => :TOKEN,
        # )

        def confirmed?
          confirmation == 'Confirmed'
        end

        def street_matched?
          street_match == 'Matched'
        end

        def zip_matched?
          zip_match == 'Matched'
        end
      end
    end
  end
end
