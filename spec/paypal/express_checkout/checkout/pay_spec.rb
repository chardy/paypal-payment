require "spec_helper"

include PayPal::ExpressCheckout

describe PayPal::ExpressCheckout::Checkout do
  describe "#pay" do
    context "for Authorization" do
      context "when successful" do
        use_vcr_cassette "express_checkout/checkout/pay/success"
        # let(:payer_id) { "4YLKLC48QZJ6Y" }
        let(:token) { "EC-66R94860GU0469430" }
        let(:payment) {
          PayPal::ExpressCheckout::Payment.new(
            :payment_action     => "Authorization",
            :description        => "MacBook Air",
            :notify_url         => "http://example.com/paypal/ipn",
            :amount             => "1300.00",
            :currency           => "USD"
          )
        }
        let(:payer_id) {
          co = PayPal::ExpressCheckout::Checkout.new(:token => token)
          co.details.payer_id
        }
        subject {
          co = PayPal::ExpressCheckout::Checkout.new(
            :token              => token,
            :payer_id           => payer_id,
            :payments           => [payment]
          )
          co.pay
        }
        # it { puts "checkout.checkout_url = #{checkout.checkout_url}" }
        its(:valid?) { should be_true }
        its(:errors) { should be_empty }
        # its(:checkout_url) { should == "#{PayPal::Api.site_endpoint}?cmd=_express-checkout&token=#{token}&useraction=commit" }
      end
    end

    context "for Sale" do
      use_vcr_cassette "express_checkout/checkout/pay/sales/success"

      let(:token) { "EC-4NT45905PP4254419" }
      let(:details) { PayPal::ExpressCheckout::Checkout.new(:token => token).details }
      let(:payer_id) { details.payer_id }
      let(:payment) {
        PayPal::ExpressCheckout::Payment.new(
          :payment_action     => "Sale",
          :description        => "Awesome Shop",
          :amount             => "20.00",
          :currency           => "USD"
        )
      }

      subject {
        co = PayPal::ExpressCheckout::Checkout.new(
          :token              => token,
          :payer_id           => payer_id,
          :payments           => [payment]
        )
        co.pay
      }

      its(:valid?) { should be_true }
      its(:errors) { should be_empty }
    end
  end
end