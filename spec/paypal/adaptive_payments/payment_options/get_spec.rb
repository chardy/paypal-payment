require 'spec_helper'

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::PaymentOptions do
  let(:receiver_email) { 'chardy_1345003248_per@gmail.com' }
  let(:receiver) { Receiver.new(:email => receiver_email, :amount => 40.0) }
  let(:receiver_list) { ReceiverList.new(:receivers => [receiver]) }
  let(:payment) {
    PayPal::AdaptivePayments::Payment.new(
      :receiver => receiver,
      :currency_code => 'USD',
      :cancel_url => 'http://example.com/cancel',
      :return_url => 'http://example.com/thank_you'
    )
  }

  describe "#get" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/payment_options/get/success"#, :record => :all

      before { payment.create }

      let(:payment_options) {
        PaymentOptions.new(:pay_key => payment.pay_key)
      }

      subject { payment_options.get }

      its(:success?) { should be_true }
    end
  end
end