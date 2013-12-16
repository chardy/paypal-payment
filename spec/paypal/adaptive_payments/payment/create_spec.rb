require "spec_helper"

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::Payment do
  let(:preapproval_key) { 'PA-89578182UL033944H' }
  let(:receiver_email) { 'chardy_1345003248_per@gmail.com' }
  let(:receiver) { Receiver.new(:email => receiver_email, :amount => 10.0) }
  let(:receiver_list) { ReceiverList.new(:receivers => [receiver]) }

  describe "#create" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/payment/create/success"#, :record => :all

      let(:payment) {
        PayPal::AdaptivePayments::Payment.new(
          :receiver => receiver,
          :preapproval_key => preapproval_key,
          :currency_code => 'USD',
          :cancel_url => 'http://example.com/cancel',
          :return_url => 'http://example.com/thank_you'
        )
      }

      subject { payment.create }

      before { subject }

      it "sets action_type to :create" do
        payment.action_type.should eql('CREATE')
      end

      it "sets the pay_key" do
        payment.pay_key.should_not be_nil
      end

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
      its(:payment_url) { should eql("https://www.sandbox.paypal.com/webscr?cmd=_ap-payment&paykey=#{payment.pay_key}") }
    end

    context "when failure" do
      use_vcr_cassette "adaptive_payments/payment/create/failure"#, :record => :all

      let(:payment) {
        PayPal::AdaptivePayments::Payment.new(
          :receiver => receiver,
          :currency_code => 'USD',
          :cancel_url => 'example.com/cancel',
          :return_url => 'http://example.com/thank_you'
        )
      }

      subject { payment.create }

      before { subject }

      its(:success?) { should be_false }
      its(:valid?) { should be_false }
      its(:errors) { should have(1).item }
    end
  end
end