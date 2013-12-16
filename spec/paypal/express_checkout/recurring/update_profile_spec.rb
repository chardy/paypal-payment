require "spec_helper"

describe PayPal::ExpressCheckout::Response::Profile do
  let(:profile_id) { "I-2YXA7FG2X8AJ" }

  context "when successful" do
    use_vcr_cassette "express_checkout/recurring/update_profile/success"

    let(:paypal) {
      PayPal::ExpressCheckout::Recurring.new({
        :description => "Awesome - Monthly Subscription (Updated)",
        :amount      => "10.00",
        :currency    => "BRL",
        :note        => "Changed Plan",
        :profile_id  => profile_id
      })
    }

    subject { paypal.update_profile }

    it { should be_valid }
    its(:profile_id) { should == profile_id }
    its(:errors) { should be_empty }
  end

  context "updated profile" do
    use_vcr_cassette "express_checkout/recurring/update_profile/profile"

    let(:paypal) { PayPal::ExpressCheckout::Recurring.new(:profile_id => profile_id) }
    subject { paypal.profile }

    its(:amount) { should eql("10.00") }
    its(:description) { should eql("Awesome - Monthly Subscription (Updated)") }
  end

  context "when failure" do
    use_vcr_cassette "express_checkout/recurring/update_profile/failure"

    let(:paypal) {
      PayPal::ExpressCheckout::Recurring.new({
        :profile_id => profile_id,
        :amount     => "10.00"
      })
    }
    subject { paypal.update_profile }

    it { should_not be_valid }
    its(:errors) { should have(1).items }
  end
end