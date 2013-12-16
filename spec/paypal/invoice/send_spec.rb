require "spec_helper"

include PayPal::Invoice

describe PayPal::Invoice::Invoice do
  describe "#send_invoice" do
    context "when successful" do
      use_vcr_cassette "invoice/send/success"#, :record => :all

      let(:invoice) {
        PayPal::Invoice::Invoice.new(
          :merchant_email => 'chardy_1345003248_per@gmail.com',
          :payer_email => 'chardy_1345003165_per@gmail.com',
          :item_list => {
            :item => [
              {
                :name => 'iPhone 5',
                :quantity => 1,
                :unit_price => 1000.0
              }
            ]
          },
          :currency_code => 'USD',
          :payment_terms => 'Net30'
        )
      }

      before { invoice.create }

      subject { invoice.send_invoice }

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
    end

    # context "when failure" do
    #   use_vcr_cassette "invoice/send/failure"#, :record => :all

    #   subject { invoice.send }

    #   before { subject }

    #   its(:success?) { should be_false }
    #   its(:valid?) { should be_false }
    #   its(:errors) { should_not be_empty }
    # end
  end
end