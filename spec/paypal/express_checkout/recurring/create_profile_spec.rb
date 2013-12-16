require "spec_helper"

describe PayPal::ExpressCheckout::Recurring do
  describe "#create_profile" do
    context "when successful" do
      use_vcr_cassette "express_checkout/recurring/create_profile/success"

      let(:token) { "EC-2EV77664BK856305S" }
      let(:payer_id) {
        rco = PayPal::ExpressCheckout::Checkout.new(:token => token)
        rco.details.payer_id
      }

      subject {
        ppr = PayPal::ExpressCheckout::Recurring.new({
          :amount                         => "9.00",
          :initial_amount                 => "9.00",
          :failed_initial_action          => :cancel,
          :currency                       => "USD",
          :description                    => "Awesome - Monthly Subscription",
          :frequency                      => 1,
          :token                          => token,
          :period                         => :monthly,
          :reference                      => "1234",
          :payer_id                       => payer_id,
          :start_at                       => Time.now,
          :max_failed_payments            => 1,
          :auto_bill_outstanding          => :next_billing
        })

        ppr.create_profile
      }

      it { should be_valid }

      its(:profile_id) { should eql("I-3LJF616J1FB7") }
      its(:profile_status) { should eql("PendingProfile") }
      its(:errors) { should be_empty }
    end

    context "when failure" do
      use_vcr_cassette "express_checkout/recurring/create_profile/failure"

      subject { PayPal::ExpressCheckout::Recurring.new.create_profile }

      it { should_not be_valid }
      its(:errors) { should have(5).items }
    end
  end
end
