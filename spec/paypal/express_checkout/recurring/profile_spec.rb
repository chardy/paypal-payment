# -*- encoding: utf-8 -*-
require "spec_helper"

describe PayPal::ExpressCheckout::Response::Profile do
  describe "#profile" do
    context "when successful" do
      use_vcr_cassette "express_checkout/recurring/profile/success"
      let(:paypal) { PayPal::ExpressCheckout::Recurring.new(:profile_id => "I-1RFWFFS16BF4") }
      subject { paypal.profile }

      it { should_not be_active }

      its(:status) { should == :cancelled }
      its(:profile_id) { should == "I-1RFWFFS16BF4" }
      its(:auto_bill_outstanding) { should == :next_billing }
      its(:description) { should == "Awesome - Monthly Subscription" }
      its(:subscriber_name) { should == "Chardy Wang" }
      its(:reference) { should == "1234" }
      its(:max_failed_payments) { should == "1" }
      its(:start_at) { should be_a(Time) }
      its(:cycles_completed) { should == "1" }
      its(:cycles_remaining) { should == "18446744073709551615" }
      its(:outstanding_balance) { should == "0.00" }
      its(:failed_payment_count) { should == "0" }
      its(:last_payment_date) { should be_a(Time) }
      its(:last_payment_amount) { should == "9.00" }
      its(:period) { should == :monthly }
      its(:frequency) { should == "1" }
      its(:currency) { should == "USD" }
      its(:amount) { should == "9.00" }
    end

    context "when failure" do
      use_vcr_cassette "express_checkout/recurring/profile/failure"
      let(:paypal) { PayPal::ExpressCheckout::Recurring.new(:profile_id => "invalid") }
      subject { paypal.profile }

      it { should_not be_valid }
      it { should_not be_success }

      its(:errors) { should have(1).item }
    end
  end
end
