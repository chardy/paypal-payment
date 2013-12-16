require "spec_helper"

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::Payment do
  let(:receiver_email) { 'chardy_1345003248_per@gmail.com' }
  let(:receiver) { Receiver.new(:email => receiver_email, :amount => 10.0) }
  let(:receiver_list) { ReceiverList.new(:receivers => [receiver]) }
  let(:payment) {
    PayPal::AdaptivePayments::Payment.new(
      :receiver => receiver,
      :currency_code => 'USD',
      :cancel_url => 'http://example.com/cancel',
      :return_url => 'http://example.com/thank_you'
    )
  }
  let(:pay_key) { payment.pay_key }
  let(:details) { payment.details }

  describe "#details" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/payment/details/success"#, :record => :all

      subject { details }

      before { payment.create }

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
      its(:payment_info) { should eq(details.payment_info_list.payment_info) }
      its(:receiver) { should eq(details.payment_info_list.payment_info.first.receiver) }
    end
  end
end