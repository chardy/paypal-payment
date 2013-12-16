require "spec_helper"

describe PayPal::ExpressCheckout::Response::Account do
  let(:response) { MockResponse.new(body_str) }
  let(:body_str) { "ACK=Success&L_AMT0=10.0&L_CURRENCYCODE0=SGD&L_AMT1=20.0&L_CURRENCYCODE1=USD" }

  describe "fields" do
    subject { PayPal::ExpressCheckout::Response::Account.new(response) }

    its(:methods) { should include(:ack) }
  end

  describe "#balances" do

    subject { PayPal::ExpressCheckout::Response::Account.new(response) }

    its(:balances) { should have(2).items }
    it "first item should be the correct amount and currency" do
      subject.balances.first.should eql(
        {
          :amount => 10.0, :currency => 'SGD'
        }
      )
    end
    it "last item should be the correct amount and currency" do
      subject.balances.last.should eql(
        {
          :amount => 20.0, :currency => 'USD'
        }
      )
    end
  end
end
