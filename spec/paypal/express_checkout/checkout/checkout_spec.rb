require "spec_helper"

include PayPal::ExpressCheckout

describe PayPal::ExpressCheckout::Checkout do
  describe "#checkout" do
    context "for authorization (Recurring)" do
      context "when successful" do
        use_vcr_cassette "express_checkout/checkout/checkout/success"
        let(:token) { "EC-2EV77664BK856305S" }
        let(:payment) {
          PayPal::ExpressCheckout::Payment.new(
            :payment_action     => "Authorization",
            :description        => "Awesome - Monthly Subscription",
            :notify_url         => "http://example.com/paypal/ipn",
            :amount             => "9.00",
            :currency           => "USD"
          )
        }
        let(:billing) {
          PayPal::ExpressCheckout::Billing.new(
            :type               => 'RecurringPayments',
            :description        => "Awesome - Monthly Subscription"
          )
        }
        subject {
          ppc = PayPal::ExpressCheckout::Checkout.new({
            :return_url         => "http://example.com/thank_you",
            :cancel_url         => "http://example.com/canceled",
            :billings           => [ billing ],
            :payments           => [ payment ]
          })

          ppc.checkout
        }

        its(:valid?) { should be_true }
        its(:errors) { should be_empty }
        its(:checkout_url) { should == "#{PayPal::Api.site_endpoint}?cmd=_express-checkout&token=#{token}&useraction=commit" }
      end
    end

    context "for sales" do
      context "when successful" do
        use_vcr_cassette "express_checkout/checkout/checkout/sales/success"

        let(:token) { "EC-12X82860F72356252" }
        let(:payment) {
          PayPal::ExpressCheckout::Payment.new(
            :payment_action     => "Sale",
            :description        => "Awesome Shop",
            :amount             => "20.00",
            :currency           => "USD"
          )
        }
        subject {
          ppc = PayPal::ExpressCheckout::Checkout.new({
            :return_url         => "http://example.com/thank_you",
            :cancel_url         => "http://example.com/canceled",
            :payments           => [ payment ]
          })

          response = ppc.checkout
          response
        }

        its(:valid?) { should be_true }
        its(:errors) { should be_empty }
        its(:checkout_url) { should == "#{PayPal::Api.site_endpoint}?cmd=_express-checkout&token=#{token}&useraction=commit" }
      end
    end
  end
end