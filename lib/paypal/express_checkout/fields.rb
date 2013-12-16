module PayPal
  module ExpressCheckout
    module Fields
      ATTRIBUTES = {
        :checkout => {
          :max_amount                         => "MAXAMT",
          :return_url                         => "RETURNURL",
          :cancel_url                         => "CANCELURL",
          :callback                           => "CALLBACK",
          :callback_timeount                  => "CALLBACKTIMEOUT",
          :confirm_shipping                   => "REQCONFIRMSHIPPING", # 0, 1
          :no_shipping                        => "NOSHIPPING",
          :allow_note                         => "ALLOWNOTE",
          :address_override                   => "ADDROVERRIDE",
          :callback_version                   => "CALLBACKVERSION",
          :locale                             => "LOCALECODE",
          :page_style                         => "PAGESTYLE",
          :header_image                       => "HDRIMG",
          :header_border_color                => "HDRBORDERCOLOR",
          :header_background_color            => "HDRBACKCOLOR",
          :payflow_color                      => "PAYFLOWCOLOR",
          :solution_type                      => "SOLUTIONTYPE", # Sole, Mark
          :landing_page                       => "LANDINGPAGE", # Billing, Login
          :channel_type                       => "CHANNELTYPE", # Merchant, eBayItem
          :brand_name                         => "BRANDNAME",
          :customer_service_num               => "CUSTOMERSERVICENUMBER",
          :phone_num                          => "PHONENUM",
          :token                              => "TOKEN",
          :payer_id                           => "PAYERID",
          :return_fmf_details                 => "RETURNFMFDETAILS", # 0, 1
          :paypal_adjustment                  => "PAYPALADJUSTMENT",
          :redirect_required                  => "REDIRECTREQUIRED",
          :checkout_status                    => "CHECKOUTSTATUS"
        },
        :giro => {
          :giropay_success_url                => "GIROPAYSUCCESSURL",
          :giropay_cancel_url                 => "GIROPAYCANCELURL",
          :bank_txn_pending_url               => "BANKTXNPENDINGURL",
        },
        :gift => {
          :gift_message                       => "GIFTMESSAGE",
          :gift_receipt_enabled               => "GIFTRECEIPTENABLE",
          :gift_wrap_name                     => "GIFTWRAPNAME",
          :gift_wrap_amount                   => "GIFTWRAPAMOUNT"
        },
        :survey => {
          :survey_question                    => "SURVEYQUESTION",
          :survey_enabled                     => "SURVEYENABLE",  # 0, 1
          :survey_choice_selected             => "SURVEYCHOICESELECTED",
          :survey_choices                     => "L_SURVEYCHOICEn"
        },
        :ship_to => {
          :ship_to_name                       => 'SHIPTONAME',
          :ship_to_street                     => 'SHIPTOSTREET',
          :ship_to_street_2                   => 'SHIPTOSTREET2',
          :ship_to_city                       => 'SHIPTOCITY',
          :ship_to_state                      => 'SHIPTOSTATE',
          :ship_to_zip                        => 'SHIPTOZIP',
          :ship_to_country                    => 'SHIPTOCOUNTRYCODE',
          :ship_to_phone_num                  => 'SHIPTOPHONENUM',
          :ship_to_secondary_name             => 'SHIPTOSECONDARYNAME',
          :ship_to_secondary_address_line_1   => 'SHIPTOSECONDARYADDRESSLINE1',
          :ship_to_secondary_address_line_2   => 'SHIPTOSECONDARYADDRESSLINE2',
          :ship_to_secondary_city             => 'SHIPTOSECONDARYCITY',
          :ship_to_secondary_state            => 'SHIPTOSECONDARYSTATE',
          :ship_to_secondary_zip              => 'SHIPTOSECONDARYZIP',
          :ship_to_secondary_country          => 'SHIPTOSECONDARYCOUNTRYCODE',
          :ship_to_secondary_phone_no         => 'SHIPTOSECONDARYPHONENUM',
          :address_status                     => "ADDRESSSTATUS",
          :address_normalization_statu        => "ADDRESSNORMALIZATIONSTATUS"
        },
        :recurring => {
          :subscriber_name                    => "SUBSCRIBERNAME",
          :start_at                           => "PROFILESTARTDATE",
          :description                        => "DESC",
          :max_failed_payments                => "MAXFAILEDPAYMENTS",
          :auto_bill_outstanding              => "AUTOBILLOUTAMT",
          :reference                          => "PROFILEREFERENCE",
          :amount                             => "AMT",
          :currency                           => "CURRENCYCODE",
          :period                             => "BILLINGPERIOD",
          :frequency                          => "BILLINGFREQUENCY",
          :additional_billing_cycles          => "ADDITIONALBILLINGCYCLES",
          :total_cycles                       => "TOTALBILLINGCYCLES",
          :trial_period                       => "TRIALBILLINGPERIOD",
          :trial_frequency                    => "TRIALBILLINGFREQUENCY",
          :trial_total_cycles                 => "TRIALTOTALBILLINGCYCLES",
          :trial_amount                       => "TRIALAMT",
          :initial_amount                     => "INITAMT",
          :outstanding_amount                 => "OUTSTANDINGAMT",
          :failed_initial_action              => "FAILEDINITAMTACTION",
          :profile_id                         => "PROFILEID",
          :profile_status                     => "PROFILESTATUS",
          :token                              => "TOKEN",
          :transaction_id                     => "TRANSACTIONID",
          :action                             => "ACTION",
          :note                               => "NOTE",
          :status                             => "STATUS",
          :aggregate_amount                   => "AGGREGATEAMOUNT",
          :aggregate_optional_amount          => "AGGREGATEOPTIONALAMOUNT",
          :final_payment_due_date             => "FINALPAYMENTDUEDATE",
          :next_billing_date                  => "NEXTBILLINGDATE",
          :cycles_completed                   => "NUMCYCLESCOMPLETED",
          :cycles_remaining                   => "NUMCYCLESREMAINING",
          :outstanding_balance                => "OUTSTANDINGBALANCE",
          :failed_payment_count               => "FAILEDPAYMENTCOUNT",
          :last_payment_date                  => "LASTPAYMENTDATE",
          :last_payment_amount                => "LASTPAYMENTAMT"
        },
        :amount => {
          :amount                             => "AMT",
          :currency                           => "CURRENCYCODE",
          :item_amount                        => "ITEMAMT",
          :shipping_amount                    => "SHIPPINGAMT",
          :shipping_discount_amount           => "SHIPDISCAMT",
          :insurance_amount                   => "INSURANCEAMT",
          :handling_amount                    => "HANDLINGAMT",
          :fee_amount                         => "FEEAMT",
          :settle_amount                      => "SETTLEAMT",
          :tax_amount                         => "TAXAMT",
          :net_amount                         => "NETAMT",
          :regular_amount                     => "REGULARAMT",
          :regular_shipping_amount            => "REGULARSHIPINGAMT",
          :regular_tax_amount                 => "REGULARTAXAMT",
          :regular_currency                   => "REGULARCURRENCYCODE"
        },
        :payment => {
          :timestamp                          => "TIMESTAMP",
          :time_zone                          => "TIMEZONE",
          :shipping_calculation_mode          => "SHIPPINGCALCULATIONMODE",
          :insurance_option_selected          => "INSURANCEOPTIONSELECTED",
          :transaction_id                     => "TRANSACTIONID",
          :parent_transaction_id              => "PARENTTRANSACTIONID",
          :transaction_type                   => "TRANSACTIONTYPE",
          :receipt_id                         => "RECEIPTID",
          :payment_type                       => "PAYMENTTYPE",
          :profile_id                         => "PROFILEID",
          :order_time                         => "ORDERTIME",
          :description                        => "DESC",
          :custom                             => "CUSTOM",
          :button_source                      => "BUTTONSOURCE",
          :notify_url                         => "NOTIFYURL",
          :recurring                          => "RECURRING",
          :insurance_offered                  => "INSURANCEOPTIONOFFERED",
          :allowed_payment_method             => "ALLOWEDPAYMENTMETHOD",
          :payment_action                     => "PAYMENTACTION",
          :payment_request_id                 => "PAYMENTREQUESTID",
          :exchange_rate                      => "EXCHANGERATE",
          :status                             => "PAYMENTSTATUS",
          :reason                             => "PAYMENTREASON",
          :pending_reason                     => "PENDINGREASON",
          :reason_code                        => "REASONCODE",
          :protection_eligibility             => "PROTECTIONELIGIBILITY",
          :protection_eligibility_type        => "PROTECTIONELIGIBILITYTYPE",
          :ip_address                         => "IPADDRESS",
          :confirm_shipping                   => "REQCONFIRMSHIPPING", # 0, 1
          :return_fmf_details                 => "RETURNFMFDETAILS", # 0, 1
          :soft_descriptor                    => "SOFTDESCRIPTOR",
          :msg_sub_id                         => "MSGSUBID",
          :store_id                           => "STOREID",
          :terminal_id                        => "TERMINALID",
          :invoice_num                        => "INVNUM",
          :note_text                          => "NOTETEXT",
          :note                               => "NOTE",
          :sales_tax                          => "SALESTAX",
          :name                               => "NAME",
          :action                             => "ACTION",
          :seller_account_id                  => "SELLERPAYPALACCOUNTID",
          :authorization_id                   => "AUTHORIZATIONID"
        },
        :seller => {
          :seller_id                          => "SELLERID",
          :seller_username                    => "SELLERUSERNAME",
          :seller_registration_date           => "SELLERREGISTRATIONDATE"
        },
        :payment_item => {
          :ebay_number                        => "EBAYITEMNUMBER",
          :ebay_auction_txn_id                => "EBAYITEMAUCTIONTXNID",
          :ebay_order_id                      => "EBAYITEMORDERID",
          :ebay_cart_id                       => "EBAYCARTID",
          :item_url                           => "ITEMURL",
          :item_category                      => "ITEMCATEGORY",
          :name                               => "NAME",
          :description                        => "DESC",
          :number                             => "NUMBER",
          :quantity                           => "QTY",
          :coupon_id                          => "COUPONID",
          :coupon_amount                      => "COUPONAMOUNT",
          :coupon_amount_currency             => "COUPONAMOUNTCURRENCY",
          :card_discount                      => "LOYALTYCARDDISCOUNTAMOUNT",
          :card_discount_currency             => "LOYALTYCARDISCOUNTCURRENCY",
          :amount                             => "AMT",
          :options_name                       => "OPTIONSNAME",
          :options_value                      => "OPTIONSVALUE",
          :weight_value                       => "ITEMWEIGHTVALUE",
          :weight_unit                        => "ITEMWEIGHTUNIT",
          :length_value                       => "ITEMLENGTHVALUE",
          :length_unit                        => "ITEMLENGTHUNIT",
          :width_value                        => "ITEMWIDTHVALUE",
          :width_unit                         => "ITEMWIDTHUNIT",
          :height_value                       => "ITEMHEIGHTVALUE",
          :height_unit                        => "ITEMHEIGHTUNIT"
        },
        :payment_info => {
          :short_message                      => "SHORTMESSAGE",
          :long_message                       => "LONGMESSAGE",
          :error_code                         => "ERRORCODE",
          :severity_code                      => "SEVERITYCODE",
          :ack                                => "ACK"
        },
        :funding_source => {
          :allow_push_funding                 => "ALLOWPUSHFUNDING" # 0, 1
        },
        :buyer => {
          :buyer_id                           => "BUYERID",
          :buyer_username                     => "BUYERUSERNAME",
          :buyer_registration_date            => "BUYERREGISTRATIONDATE"
        },
        :billing => {
          :type                               => "BILLINGTYPE",
          :description                        => "BILLINGAGREEMENTDESCRIPTION",
          :custom                             => "BILLINGAGREEMENTCUSTOM",
          :payment_type                       => "PAYMENTTYPE"
        },
        :payer => {
          :buyer_marketing_email              => "BUYERMARKETINGEMAIL",
          :email                              => "EMAIL",
          :payer_id                           => "PAYERID",
          :payer_status                       => "PAYERSTATUS",
          :payer_country                      => "COUNTRYCODE",
          :payer_business                     => "PAYERBUSINESS",
          :business                           => "BUSINESS",
          :salutation                         => "SALUTATION",
          :first_name                         => "FIRSTNAME",
          :middle_name                        => "MIDDLENAME",
          :last_name                          => "LASTNAME",
          :suffix                             => "SUFFIX"
        },
        :receiver => {
          :receiver_business                  => "RECEIVERBUSINESS",
          :receiver_email                     => "RECEIVEREMAIL",
          :receiver_id                        => "RECEIVERID"
        },
        :auction => {
          :buyer_id                           => "BUYERID",
          :closing_date                       => "CLOSINGDATE",
          :multi_item                         => "MULTIITEM"
        },
        :subscription => {
          :subscription_amount                => "AMOUNT",
          :period                             => "PERIOD"
        },
        :tax => {
          :tax_id_type                        => "TAXIDTYPE",
          :tax_id                             => "TAXID"
        },
        :shipping_option => {
          :insurance_selected                 => "INSURANCEOPTIONSELECTED",
          :is_default                         => "SHIPPINGOPTIONISDEFAULT",
          :name                               => "SHIPPINGOPTIONNAME",
          :label                              => "SHIPPINGOPTIONLABEL",
          :amount                             => "SHIPPINGOPTIONAMOUNT",
          :tax_amount                         => "TAXAMT",
          :insurance_amount                   => "INSURANCEAMOUNT"
        },
        :credit_card => {
          :credit_card_type                   => "CREDITCARDTYPE",
          :account                            => "ACCT",
          :expiry_date                        => "EXPDATE",
          :cvv2                               => "CVV2",
          :start_date                         => "STARTDATE",
          :issue_number                       => "ISSUENUMBER"
        },
        :address => {
          :address_owner                      => "ADDRESSOWNER",
          :address_status                     => "ADDRESSSTATUS",
          :street                             => "STREET",
          :street_2                           => "STREET2",
          :city                               => "CITY",
          :state                              => "STATE",
          :zip                                => "ZIP",
          :country                            => "COUNTRYCODE",
          :phone_num                          => "PHONENUM",
          :confirmation                       => "CONFIRMATIONCODE",
          :street_match                       => "STREETMATCH",
          :zip_match                          => "ZIPMATCH"
        },
        :search => {
          :start_date                         => "STARTDATE",
          :end_date                           => "ENDDATE",
          :receiver                           => "RECEIVER",
          :auction_item_num                   => "AUCTIONITEMNUMBER",
          :transaction_class                  => "TRANSACTIONCLASS"
        },
        :refund => {
          :refund_type                        => "REFUNDTYPE",
          :retry_until                        => "RETRYUNTIL",
          :refund_source                      => "REFUNDSOURCE",
          :store_details                      => "MERCHANTSTOREDETAILS",
          :invoice_id                         => "INVOICEID",
          :advice                             => "REFUNDADVICE",
          :refund_item_details                => "REFUNDITEMDETAILS",
          :refund_transaction_id              => "REFUNDTRANSACTIONID",
          :fee_refund_amount                  => "FEEREFUNDAMT",
          :gross_refund_amount                => "GROSSREFUNDAMT",
          :net_refund_amount                  => "NETREFUNDAMT",
          :total_refunded_amount              => "TOTALREFUNDEDAMOUNT",
          :refund_info                        => "REFUNDINFO",
          :refund_status                      => "REFUNDSTATUS",
          :pending_reason                     => "PENDINGREASON"
        },
        :account => {
          :all_currencies                     => "RETURNALLCURRENCIES",
          :pal                                => "PAL",
          :locale                             => "LOCALE"
        },
        :response => {
          :token                              => "TOKEN",
          :ack                                => "ACK",
          :version                            => "VERSION",
          :build                              => "BUILD",
          :correlaction_id                    => "CORRELATIONID",
          :requested_at                       => "TIMESTAMP"
        },
        :reference => {
          :avs_code                           => "AVSCODE",
          :cvv2_match                         => "CVV2MATCH",
          :billing_agreement_id               => "BILLINGAGREEMENTID",
          :payment_advice_code                => "PAYMENTADVICECODE"
        },
        :fmf => {
          :pending_id                         => "FMFPENDINGID",
          :pending_name                       => "FMFPENDINGNAME",
          :report_id                          => "FMFREPORTID",
          :report_name                        => "FMFREPORTNAME",
          :deny_id                            => "FMFDENYID",
          :deny_name                          => "FMFDENYNAME"
        },
        :callback => {
          :token                              => "TOKEN",
          :locale                             => "LOCALECODE",
          :currency                           => "CURRENCYCODE",
          :offer_insurance_option             => "OFFERINSURANCEOPTION",
          :no_shipping                        => "NO_SHIPPING_OPTION_DETAILS"
        }
      }

      ASSOCIATIONS = {
        :shipping_options                     => ATTRIBUTES[:shipping_option],
        :billings                             => ATTRIBUTES[:billing],
        :payment_items                        => ATTRIBUTES[:payment_item].
                                                  merge(ATTRIBUTES[:amount]),
        :payments                             => ATTRIBUTES[:payment].
                                                  merge(ATTRIBUTES[:amount]).
                                                  merge(ATTRIBUTES[:ship_to]).
                                                  merge(ATTRIBUTES[:seller]),
        :fmfs                                 => ATTRIBUTES[:fmf]
      }

      def self.included(base)
        base.extend(ClassMethods)
        base.inheritable_attributes :field_groups, :associations
        base.instance_variable_set("@field_groups", [])
        base.instance_variable_set("@associations", [])
      end

      module ClassMethods
        def field_groups
          @field_groups ||= []
        end

        def associations
          @associations ||= []
        end

        def field_map
          @field_map ||= field_groups.inject({}) do |memo, group|
            memo.merge(ATTRIBUTES[group])
          end.merge(ASSOCIATIONS.select{ |k,v| associations.include?(k) })
        end

        def inverted_field_map
          @inverted_field_map ||= field_map.invert
        end

        def has_fields(*args)
          @field_groups += (args & ATTRIBUTES.keys)
          @field_groups.each do |group|
            ATTRIBUTES[group].each_key do |field|
              attr_accessor field
            end
          end
        end

        def has_many(*args)
          @associations += (args & ASSOCIATIONS.keys)
          @associations.each do |many|
            attr_accessor many
            class_eval %(
              def #{many}; @#{many} ||= [] end
            )
          end
        end

        def inheritable_attributes(*args)
          @inheritable_attributes ||= [:inheritable_attributes]
          @inheritable_attributes += args
          args.each do |arg|
            class_eval %(
              class << self; attr_accessor :#{arg} end
            )
          end
          @inheritable_attributes
        end

        def inherited(subclass)
          @inheritable_attributes.each do |inheritable_attribute|
            instance_var = "@#{inheritable_attribute}"
            subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
          end
        end
      end

      def group_collect(*args)
        collect(*group_fields(*args))
      end

      def group_fields(*args)
        Array(args).map { |group| ATTRIBUTES[group] ? ATTRIBUTES[group].keys : group }.flatten
      end

      def field_map
        self.class.field_map
      end

      def inverted_field_map
        self.class.inverted_field_map
      end

      def has_fields?(group)
        self.class.field_groups.include?(group)
      end

      def has_many?(association)
        self.class.associations.include?(association)
      end
    end
  end
end