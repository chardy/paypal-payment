require "spec_helper"

describe PayPal::ExpressCheckout::Payment do
  let(:payment) { PayPal::ExpressCheckout::Payment.new }

  describe "methods" do
    subject { payment.methods }

    [:amount, :shipping_amount, :tax_amount].each do |field|
      it { should include(field) }
    end
  end
end