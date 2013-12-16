require "spec_helper"

describe PayPal::Request do
  describe "#post" do
    before :all do
      VCR.eject_cassette
      VCR.turn_off!
    end

    after :all do
      VCR.turn_on!
    end

    let(:uri) { "https://api-3t.sandbox.paypal.com/nvp" }
    let(:username) { "test@api.com" }
    let(:password) { "testpassword" }

    before do
      subject.uri = uri
    end

    it "verifies certificate" do
      stub_request(:post, uri).to_return(:status => 200, :body => "", :headers => {})
      Curl::Easy.any_instance.should_receive(:ssl_verify_host=).with(true)
      Curl::Easy.any_instance.should_receive(:ssl_verify_peer=).with(true)
      subject.post
    end

    it "sets cacert" do
      stub_request(:post, uri).to_return(:status => 200, :body => "", :headers => {})
      Curl::Easy.any_instance.should_receive(:cacert=).with(File.expand_path("../../../lib/paypal/cacert.pem", __FILE__))
      subject.post
    end

    it "sets body" do
      stub_request(:post, uri).with(:body => 'AMT=10.00')
      subject.post({'AMT' => '10.00'})
    end

    it "sets headers" do
      stub_request(:post, uri).with(:headers => {'X-PAYPAL-SECURITY-USERID' => username})
      subject.post({}, {'X-PAYPAL-SECURITY-USERID' => username})
    end
  end
end
