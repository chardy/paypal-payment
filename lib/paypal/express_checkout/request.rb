module PayPal
  module ExpressCheckout
    class Request < PayPal::Request
      METHODS = {
        :address_verify       => "AddressVerify",
        :authorize            => "DoAuthorization",
        :balance              => "GetBalance",
        :pal_details          => "GetPalDetails",
        :bill_outstanding     => "BillOutstandingAmount",
        :capture              => "DoCapture",
        :reauthorize          => "DoReauthorization",
        :checkout             => "SetExpressCheckout",
        :pay                  => "DoExpressCheckoutPayment",
        :details              => "GetExpressCheckoutDetails",
        :create_profile       => "CreateRecurringPaymentsProfile",
        :profile              => "GetRecurringPaymentsProfileDetails",
        :manage_profile       => "ManageRecurringPaymentsProfileStatus",
        :update_profile       => "UpdateRecurringPaymentsProfile",
        :refund               => "RefundTransaction",
        :search               => "TransactionSearch",
        :update_status        => "ManagePendingTransactionStatus",
        :transaction_details  => "GetTransactionDetails",
        :reference            => "DoReferenceTransaction",
        :callback_response    => "CallbackResponse"
      }

      INITIAL_AMOUNT_ACTIONS = {
        :cancel   => "CancelOnFailure",
        :continue => "ContinueOnFailure"
      }

      ACTIONS = {
        :accept     => "Accept",
        :deny       => "Deny",
        :cancel     => "Cancel",
        :suspend    => "Suspend",
        :reactivate => "Reactivate"
      }

      PERIOD = {
        :daily        => "Day",
        :weekly       => "Week",
        :semi_monthly => "SemiMonth",
        :monthly      => "Month",
        :yearly       => "Year"
      }

      TRIAL_PERIOD = {
        :daily        => "Day",
        :weekly       => "Week",
        :semi_monthly => "SemiMonth",
        :monthly      => "Month",
        :yearly       => "Year"
      }

      OUTSTANDING = {
        :next_billing => "AddToNextBilling",
        :no_auto      => "NoAutoBill"
      }

      REFUND_TYPE  = {
        :full     => "Full",
        :partial  => "Partial",
        :external => "ExternalDispute",
        :other    => "Other"
      }

      def default_params
        {
          :USER         => PayPal::ExpressCheckout::Api.username,
          :PWD          => PayPal::ExpressCheckout::Api.password,
          :SIGNATURE    => PayPal::ExpressCheckout::Api.signature,
          :VERSION      => PayPal::ExpressCheckout::Api.api_version
        }
      end

      def field_map(object)
        object.class.field_map
      end

      def normalize_params(object, params)
        attributes = field_map(object)
        params.inject({}) do |buffer, (name, value)|
          attr_names = [attributes[name.to_sym]].flatten.compact
          attr_names << name if attr_names.empty?

          attr_names.each do |attr_name|
            if (attr_name =~ /n/ or attr_name.is_a?(Hash)) and respond_to?("build_#{name}")
              send("build_#{name}", attr_name, value, buffer)
            else
              buffer[attr_name.to_sym] = respond_to?("build_#{name}") ? send("build_#{name}", value) : value
            end
          end

          buffer
        end
      end

      # Parse current API url.
      #
      def uri # :nodoc:
        @uri ||= PayPal::ExpressCheckout::Api.api_endpoint
      end

      def api_methods
        METHODS
      end

      def run(object, method, params = {}, headers = {})
        params = prepare_params(object, params.merge(:method => api_methods.fetch(method, method.to_s)))
        headers = prepare_headers(headers)
        response = post(params, headers)
        PayPal::ExpressCheckout::Response.process(method, response)
      end

      def prepare_params(object, params) # :nodoc:
        normalize_params(object, default_params.merge(params))
      end

      def build_period(value) # :nodoc:
        PERIOD.fetch(value.to_sym, value) if value
      end

      def build_trial_period(value)
        TRIAL_PERIOD.fetch(value.to_sym, value) if value
      end

      def build_start_at(value) # :nodoc:
        build_time(value)
      end

      def build_start_date(value) # :nodoc:
        build_time(value)
      end

      def build_end_date(value) # :nodoc:
        build_time(value)
      end

      def build_auto_bill_outstanding(value) # :nodoc:
        OUTSTANDING.fetch(value.to_sym, value) if value
      end

      def build_refund_type(value) # :nodoc:
        REFUND_TYPE.fetch(value.to_sym, value) if value
      end

      def build_action(value) # :nodoc:
        ACTIONS.fetch(value.to_sym, value) if value
      end

      def build_failed_initial_action(value) # :nodoc:
        INITIAL_AMOUNT_ACTIONS.fetch(value.to_sym, value) if value
      end

      def build_locale(value) # :nodoc:
        value.to_s.upcase
      end

      def build_survey_choices(attr_name, values, buffer)
        Array(values).each_with_index do |value, idx|
          buffer[attr_name.gsub(/n/, idx.to_s).to_sym] = value
        end
      end

      def build_time(value)
        if value.respond_to?(:strftime)
          value = value.utc if value.respond_to?(:utc)
          value.strftime("%Y-%m-%dT%H:%M:%SZ")
        else
          value
        end
      end

      def build_shipping_options(attr_name, values, buffer)
        build_object_array(attr_name, values, buffer, "L_", "n")
      end

      def build_billings(attr_name, values, buffer)
        build_object_array(attr_name, values, buffer, "L_", "n")
      end

      def build_payments(attr_name, values, buffer)
        build_object_array(attr_name, values, buffer, "PAYMENTREQUEST_n_")
        Array(values).each_with_index do |payment, idx|
          build_object_array(
            PayPal::ExpressCheckout::Fields::ASSOCIATIONS[:payment_items],
            payment.payment_items,
            buffer,
            "L_PAYMENTREQUEST_#{idx}_",
            "n"
          )
        end
      end

      def build_payment_items(attr_name, values, buffer)
        build_object_array(attr_name, values, buffer, "L_", "n")
      end

      def build_object_array(attr_name, values, buffer, prefix = "L_", suffix = nil)
        Array(values).each_with_index do |value, idx|
          attr_name.each do |attribute, name|
            name = "#{prefix}#{name}#{suffix}"
            unless (v = value.send(attribute)).nil?
              buffer[name.gsub(/n/, idx.to_s).to_sym] = v
            end
          end
        end
      end
    end
  end
end
