require "spec_helper"

describe PayPal::ExpressCheckout::Response::ManageProfile do
  let(:paypal) { PayPal::ExpressCheckout::Recurring.new(:profile_id => "I-1RFWFFS16BF4") }

  context "suspending" do
    context "when successful" do
      use_vcr_cassette "express_checkout/recurring/suspend/success"
      subject { paypal.suspend }

      it { should be_success }
      it { should be_valid }
    end

    context "when failure" do
      use_vcr_cassette "express_checkout/recurring/suspend/failure"
      subject { paypal.suspend }

      it { should_not be_success }
      it { should_not be_valid }
      its(:errors) { should have(1).item }
    end
  end

  context "reactivating" do
    context "when successful" do
      use_vcr_cassette "express_checkout/recurring/reactivate/success"
      subject { paypal.reactivate }

      it { should be_success }
      it { should be_valid }
    end

    context "when failure" do
      use_vcr_cassette "express_checkout/recurring/reactivate/failure"
      subject { paypal.reactivate }

      it { should_not be_success }
      it { should_not be_valid }
      its(:errors) { should have(1).item }
    end
  end

  context "cancelling" do
    context "when successful" do
      use_vcr_cassette "express_checkout/recurring/cancel/success"
      subject { paypal.cancel }

      it { should be_success }
      it { should be_valid }
    end

    context "when failure" do
      use_vcr_cassette "express_checkout/recurring/cancel/failure"
      subject { paypal.cancel }

      it { should_not be_success }
      it { should_not be_valid }
      its(:errors) { should have(1).item }
    end
  end
end
