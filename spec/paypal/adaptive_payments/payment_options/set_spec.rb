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

  describe "#set" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/payment_options/set/success"#, :record => :all

      before { payment.create }

      let(:payment_options) {
        PaymentOptions.new(
          :pay_key => payment.pay_key,
          :display_options => {
            :email_header_image_url => "http://example.com/email_header.png",
            :email_marketing_image_url => "http://example.com/email_marketing.png",
            :business_name => "Dynosoft"
          },
          :sender_options => {
            :require_shipping_address_selection => false,
            :referrer_code => "RRRR"
          },
          :receiver_options => [
            {
              :description => "Testing",
              :customer_id => "CUST_A",
              :invoice_data => {
                :item => [
                  {
                    :name => "Item A",
                    :identifier => "AA",
                    :price => 30.0,
                    :item_price => 15.0,
                    :item_count => 2
                  }
                ],
                :total_tax => 10.0,
                :total_shipping => 0.0
              },
              :receiver => {
                :email => receiver_email
              }
            }
          ]
        )
      }

      subject { payment_options.set }

      its(:success?) { should be_true }
    end
  end
end