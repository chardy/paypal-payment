require "spec_helper"

describe PayPal::ExpressCheckout::Payment do
  describe "#refund" do
    let(:paypal) {
      PayPal::ExpressCheckout::Payment.new({
        :profile_id     => "I-9P7YSC1J6XET",
        :transaction_id => "9H105857DB8084710",
        :refund_type    => "Full",
        :amount         => "9.00",
        :currency       => "USD"
      })
    }

    context "when successful" do
      use_vcr_cassette "express_checkout/payment/refund/success"
      subject { paypal.refund }

      its(:refund_transaction_id) { should eql("4T450045RX025224L") }
      its(:fee_refund_amount) { should eql("0.26") }
      its(:gross_refund_amount) { should eql("9.00") }
      its(:net_refund_amount) { should eql("8.74") }
      its(:total_refunded_amount) { should eql("9.00") }
      its(:currency) { should eql("USD") }
    end

    context "when failure" do
      use_vcr_cassette "express_checkout/payment/refund/failure"
      subject { paypal.refund }

      its(:errors) { should have(1).items }
    end
  end
end
