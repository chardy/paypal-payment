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

  describe "#shipping_addresses" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/payment/shipping_addresses/success"#, :record => :all

      subject { payment.shipping_addresses }

      before { payment.create }

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
    end
  end
end