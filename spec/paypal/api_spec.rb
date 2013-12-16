require "spec_helper"

describe PayPal::Api do
  after do
    PayPal::Api.sandbox = true
  end

  subject { PayPal::Api }

  describe ".sandbox=" do
    before { PayPal::Api.instance.sandbox = false }
    it "sets sandbox" do
      expect{ subject.sandbox = true }.to change { PayPal::Api.instance.sandbox? }.from(false).to(true)
    end
  end

  context "when sandbox" do
    before { PayPal::Api.instance.sandbox = true }
    its(:environment) { should eql(:sandbox) }
    its(:site_endpoint) { should eql(PayPal::Api::SITE_ENDPOINTS[:sandbox]) }
  end

  context "when production" do
    before { PayPal::Api.instance.sandbox = false }
    its(:environment) { should eql(:production) }
    its(:site_endpoint) { should eql(PayPal::Api::SITE_ENDPOINTS[:production]) }
  end

  describe ".instance" do
    subject { PayPal::Api.instance }

    it "should not be nil" do
      should_not be_nil
    end

    describe "#sandbox?" do
      it "detects sandbox" do
        subject.sandbox = true
        subject.should be_sandbox
      end

      it "ignores sandbox" do
        subject.sandbox = false
        subject.should_not be_sandbox
      end
    end

    describe "#environment" do
      it "returns production" do
        subject.sandbox = false
        subject.environment.should eq(:production)
      end

      it "returns sandbox" do
        subject.sandbox = true
        subject.environment.should eq(:sandbox)
      end
    end

    describe "#configure" do
      it "yields PayPal::Api.instance" do
        subject.configure do |config|
          config.should eql(PayPal::Api.instance)
        end
      end

      it "sets attributes" do
        subject.configure do |config|
          config.sandbox = false
          config.username = "test@api.com"
        end

        subject.sandbox.should be_false
        subject.username.should eql("test@api.com")
      end
    end
  end
end
