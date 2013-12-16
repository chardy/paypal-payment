require "spec_helper"

include PayPal::ExpressCheckout

describe PayPal::ExpressCheckout::Account do
  describe "#balance" do
    context "when successful" do
      use_vcr_cassette "express_checkout/account/balance/success"

      let(:account) { Account.new }

      subject { account.balance }

      it { should be_success }
      it { should be_valid }
      its(:balances) { should have(1).item }
      it "should have the correct amount" do
        subject.balances.first[:amount].should eql(224.58)
      end
      it "should have the correct currency" do
        subject.balances.first[:currency].should eql('USD')
      end
    end
  end
end
