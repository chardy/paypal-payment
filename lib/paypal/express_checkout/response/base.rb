module PayPal
  module ExpressCheckout
    module Response
      class Base
        include PayPal::ExpressCheckout::Fields
        extend PayPal::ExpressCheckout::Utils

        attr_accessor :response

        has_fields :response

        def initialize(response = nil)
          @response = response
          build_values
        end

        def params
          @params ||= CGI.parse(response.body_str).inject({}) do |buffer, (name, value)|
            buffer.merge(name => value.first)
          end
        end

        def build_values
          params.each_pair do |key, value|
            unless key.to_s =~ /^L\_|\_(\d)+\_/
              attr_name = inverted_field_map[key.to_s]
              if respond_to?("#{attr_name}=")
                value = send("build_#{attr_name}", value) if respond_to?("build_#{attr_name}")
                send("#{attr_name}=", value)
              end
            end
          end
          self.class.associations.each do |association|
            if respond_to?("build_#{association}")
              send("build_#{association}")
            end
          end
        end

        def build_payments(prefix='PAYMENTREQUEST_n_', suffix='')
          build_association(
            :payments,
            PayPal::ExpressCheckout::Payment,
            :amount,
            prefix,
            suffix
          ).each_with_index do |p, index|
            build_payment_items("L_#{prefix}".gsub(/n/, index.to_s), "n", p)
          end
        end

        def build_payment_items(prefix="L_", suffix="n", object=self)
          build_association(:payment_items, PayPal::ExpressCheckout::PaymentItem, :amount, prefix, suffix, object)
        end

        def build_shipping_options(prefix="L_", suffix="n")
          build_association(:shipping_options, PayPal::ExpressCheckout::ShippingOption, :name, prefix, suffix)
        end

        def build_billings(prefix="L_", suffix="n")
          build_association(:billings, PayPal::ExpressCheckout::Billing, :type, prefix, suffix)
        end

        def build_fmfs(prefix="L_", suffix="n")
          build_association(:fmfs, PayPal::ExpressCheckout::Fmf, [:pending_id, :report_id, :deny_id], prefix, suffix)
        end

        def build_association(association, association_class, initial_fields, prefix="L_", suffix="n", object=self)
          initial_fields = Array(initial_fields)
          detection_fields = ASSOCIATIONS[association].map{|k,v| initial_fields.include?(k) ? v : nil}.compact
          index = 0
          index_prefix = prefix.gsub(/n/, index.to_s)
          index_suffix = suffix.gsub(/n/, index.to_s)
          while detection_fields.inject(false) { |memo, field| memo || params["#{index_prefix}#{field}#{index_suffix}"] }
            attributes = {}
            ASSOCIATIONS[association].invert.each do |name, method|
              build_method = "build_#{method}"
              value = params["#{index_prefix}#{name}#{index_suffix}"]
              attributes[method] = object.respond_to?(build_method) ? object.send(build_method, value) : value
            end
            object.send("#{association}").send("<<", association_class.new(attributes))
            index += 1
            index_prefix = prefix.gsub(/n/, index.to_s)
            index_suffix = suffix.gsub(/n/, index.to_s)
          end
          object.send(association)
        end

        def errors
          @errors ||= begin
            index = 0
            [].tap do |errors|
              while params["L_ERRORCODE#{index}"]
                errors << {
                  :code => params["L_ERRORCODE#{index}"],
                  :messages => [
                    params["L_SHORTMESSAGE#{index}"],
                    params["L_LONGMESSAGE#{index}"]
                  ]
                }

                index += 1
              end
            end
          end
        end

        def success?
          ack == "Success"
        end

        def valid?
          errors.empty? && success?
        end

        protected

        def build_requested_at(stamp) # :nodoc:
          Time.parse(stamp)
        end
        alias_method :build_timpstamp, :build_requested_at
      end
    end
  end
end
