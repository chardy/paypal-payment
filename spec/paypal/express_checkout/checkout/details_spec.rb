require "spec_helper"

include PayPal::ExpressCheckout

describe PayPal::ExpressCheckout::Checkout do
  describe "#details" do
    context "when successful" do
      use_vcr_cassette "express_checkout/checkout/details/success"#, :record => :all
      let(:payment) {
        PayPal::ExpressCheckout::Payment.new(
          :notify_url         => "http://example.com/paypal/ipn",
          :description        => "Awesome - Monthly Subscription",
          :amount             => "9.00",
          :currency           => "USD",
          :payment_action     => "Sales"
        )
      }
      let(:checkout) {
        ppc = PayPal::ExpressCheckout::Checkout.new(
          :return_url         => "http://example.com/thank_you",
          :cancel_url         => "http://example.com/canceled",
          :payments           => [ payment ]
        )

        ppc.checkout
      }
      let(:token) { checkout.token }

      subject {
        ppr = PayPal::ExpressCheckout::Checkout.new(:token => token)
        ppr.details
      }

      it { should be_valid }
      it { should be_success }

      its(:errors) { should be_empty }
      its(:checkout_status) { should == "PaymentActionNotInitiated" }
      its(:requested_at) { should be_a(Time) }
      its(:currency) { should == "USD" }
      its(:description) { should == "Awesome - Monthly Subscription" }
      its(:notify_url) { should == "http://example.com/paypal/ipn" }
    end

    # context "when cancelled" do
    #   use_vcr_cassette "details/cancelled"
    #   subject {
    #     ppr = PayPal::Recurring.new(:token => "EC-8J298813NS092694P")
    #     ppr.checkout_details
    #   }

    #   it { should be_valid }
    #   it { should be_success }

    #   its(:agreed?) { should be_false }
    # end

    context "when failure" do
      use_vcr_cassette "express_checkout/checkout/details/failure"

      subject { PayPal::ExpressCheckout::Checkout.new.details }

      it { should_not be_valid }
      it { should_not be_success }

      its(:errors) { should have(1).item }
    end
  end

end