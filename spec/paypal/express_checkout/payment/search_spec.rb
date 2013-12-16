require "spec_helper"

include PayPal::ExpressCheckout

describe PayPal::ExpressCheckout::Payment do
  describe "#search" do
    context "when successful" do
      use_vcr_cassette "express_checkout/payment/search/success"#, :record => :all
      let(:payment) {
        PayPal::ExpressCheckout::Payment.new(
          :start_date   => Date.today << 1,
          :currency     => 'USD'
        )
      }

      subject { payment.search }

      it { should be_valid }
      it { should be_success }

      its(:payments) { should_not be_empty }
    end
  end
end
