require "spec_helper"

describe PayPal::ExpressCheckout::Payment do
  describe "#details" do
    context "when successful" do
      use_vcr_cassette "express_checkout/payment/details/success"
      let(:transaction_id) { "14R798164A671130B" }
      let(:payment) { PayPal::ExpressCheckout::Payment.new(:transaction_id => transaction_id) }

      subject { payment.details }

      its(:valid?) { should be_true }
      its(:errors) { should be_empty }
      its(:payment_items) { should have(2).item }
      it "should have the correct items" do
        subject.payment_items.first.amount.should eql("1150.00")
        subject.payment_items.last.amount.should eql("1350.00")
      end
    end

    context "when failure" do
      use_vcr_cassette "express_checkout/payment/details/failure"
      let(:payment) { PayPal::ExpressCheckout::Payment.new(:transaction_id => "aaa") }

      subject { payment.details }

      its(:errors) { should have(1).items }
    end
  end
end
