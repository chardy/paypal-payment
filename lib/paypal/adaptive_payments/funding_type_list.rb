module PayPal::AdaptivePayments
  class FundingTypeList
    include PayPal::Common::Base

    attr_accessor :funding_type_info

    def set_funding_type_info(value)
      self.funding_type_info = build_value(FundingTypeInfo, value)
    end
  end
end
