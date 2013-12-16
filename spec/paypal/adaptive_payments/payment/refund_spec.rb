require "spec_helper"

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::Payment do
  let(:pay_key) { 'AP-4E8509886U908932M' }
  let(:receiver_email) { 'chardy_1345003248_per@gmail.com' }
  let(:receiver) { Receiver.new(:email => receiver_email, :amount => 10.0) }
  let(:receiver_list) { ReceiverList.new(:receivers => [receiver]) }

  describe "#refund" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/payment/refund/success"#, :record => :all

      let(:payment) {
        PayPal::AdaptivePayments::Payment.new(
          :pay_key => pay_key,
          :currency_code => 'USD'
        )
      }

      subject { payment.refund }

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
      its(:refund_infos) { should have(1).item }
    end

    context "when failure" do
      use_vcr_cassette "adaptive_payments/payment/refund/failure"#, :record => :all

      let(:payment) {
        PayPal::AdaptivePayments::Payment.new(
          :pay_key => pay_key,
          :receiver => receiver,
          :currency_code => 'USD'
        )
      }

      subject { payment.pay }

      before { subject }

      its(:success?) { should be_false }
      its(:valid?) { should be_false }
      its(:errors) { should_not be_empty }
    end
  end
end