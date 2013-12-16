require "spec_helper"

describe PayPal::AdaptivePayments::Request do
  let(:pay_uri) { "#{PayPal::AdaptivePayments::Api.api_endpoint}/#{PayPal::AdaptivePayments::Request::METHODS[:pay]}" }

  describe "#default_headers" do
    subject { PayPal::AdaptivePayments::Request.new.default_headers }

    [
      'X-PAYPAL-SECURITY-USERID',
      'X-PAYPAL-SECURITY-PASSWORD',
      'X-PAYPAL-SECURITY-SIGNATURE',
      'X-PAYPAL-REQUEST-DATA-FORMAT',
      'X-PAYPAL-RESPONSE-DATA-FORMAT',
      'X-PAYPAL-APPLICATION-ID',
      'User-Agent'
    ].each do |key|
      it "has key #{key}" do
        subject.should have_key(key)
      end
    end
  end

  describe "#method_endpoint" do
    it "sets method api endpoint" do
      subject.method_endpoint(:pay).should eql(pay_uri)
    end
  end

  describe "#run" do
    before :all do
      VCR.eject_cassette
      VCR.turn_off!
    end

    after :all do
      VCR.turn_on!
    end

    it "sets body with JSON" do
      stub_request(:post, pay_uri).
        with(:body => MultiJson.dump({:abc => 'ABC', :requestEnvelope => {:errorLanguage => 'en_US', :detailLevel => 'ReturnAll'} })).
        to_return(:status => 200, :body => "", :headers => {})

      subject.run(:pay, {:abc => 'ABC'})
    end
  end
end