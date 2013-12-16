require "spec_helper"

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::Payment do
  let(:preapproval_key) { 'PA-89578182UL033944H' }
  let(:receiver_email) { 'chardy_1345003248_per@gmail.com' }
  let(:receiver) { Receiver.new(:email => receiver_email, :amount => 10.0) }
  let(:receiver_list) { ReceiverList.new(:receivers => [receiver]) }

  describe "#pay" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/payment/pay/success"#, :record => :all

      let(:payment) {
        PayPal::AdaptivePayments::Payment.new(
          :receiver => receiver,
          :currency_code => 'USD',
          :cancel_url => 'http://example.com/cancel',
          :return_url => 'http://example.com/thank_you'
        )
      }

      subject { payment.pay }

      before { subject }

      it "sets action_type to :pay" do
        payment.action_type.should eql('PAY')
      end

      it "sets the pay_key" do
        payment.pay_key.should_not be_nil
      end

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
      its(:payment_url) { should eql("https://www.sandbox.paypal.com/webscr?cmd=_ap-payment&paykey=#{payment.pay_key}") }
    end

    context "when pay_key is set" do
      use_vcr_cassette "adaptive_payments/payment/pay/with_pay_key"#, :record => :all

      let(:pay_key) { 'AP-5C085958M3074971R' }
      let(:payment) { PayPal::AdaptivePayments::Payment.new(:pay_key => pay_key) }

      subject { payment.pay }

      it "run execute command" do
        payment.should_receive(:run_execute)
        subject
      end

      its(:success?) { should be_true }
    end

    context "when preapproval_key is set" do
      use_vcr_cassette "adaptive_payments/payment/pay/preapproval"#, :record => :all

      let(:payment) {
        PayPal::AdaptivePayments::Payment.new(
          :preapproval_key => preapproval_key,
          :receiver => receiver,
          :currency_code => 'USD',
          :cancel_url => 'http://example.com/cancel',
          :return_url => 'http://example.com/thank_you'
        )
      }

      subject { payment.pay }

      its(:success?) { should be_true }
      its(:payment_exec_status) { should eql('COMPLETED') }
    end

    context "when failure" do
      use_vcr_cassette "adaptive_payments/payment/pay/failure"#, :record => :all

      let(:payment) {
        PayPal::AdaptivePayments::Payment.new(
          :receiver => { :email => receiver_email, :amount => 10.0 },
          :currency_code => 'USD',
          :cancel_url => 'example.com/cancel',
          :return_url => 'http://example.com/thank_you'
        )
      }

      subject { payment.pay }

      before { subject }

      its(:success?) { should be_false }
      its(:valid?) { should be_false }
      its(:errors) { should have(1).item }
    end
  end
end