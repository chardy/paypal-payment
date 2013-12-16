require "spec_helper"

describe PayPal::AdaptivePayments::Api do
  let(:api) { PayPal::Api }
  let(:endpoints) { PayPal::AdaptivePayments::Api::API_ENDPOINTS }

  describe ".api_endpoints" do
    subject { PayPal::AdaptivePayments::Api.api_endpoint }

    context "when sandbox" do
      before { api.sandbox = true }
      it { should eql(endpoints[:sandbox]) }
    end

    context "when production" do
      before { api.sandbox = false }
      it { should eql(endpoints[:production]) }
    end
  end
end