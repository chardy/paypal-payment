module PayPal::AdaptivePayments
  class FundingConstraint
    include PayPal::Common::Base

    attr_accessor :allowed_funding_type

    def set_allowed_funding_type(value)
      self.allowed_funding_type = build_value(FundingTypeList, value)
    end
  end
end
