require "spec_helper"

include PayPal::ExpressCheckout

describe PayPal::ExpressCheckout::Account do
  describe "#pal_details" do
    context "when successful" do
      use_vcr_cassette "express_checkout/account/pal_details/success"

      let(:account) { Account.new }

      subject { account.pal_details }

      it { should be_success }
      it { should be_valid }
      its(:pal) { should_not be_empty }
      its(:locale) { should_not be_empty }
    end
  end
end
