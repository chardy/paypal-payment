require "spec_helper"

include PayPal::Invoice

describe PayPal::Invoice::Invoice do
  describe "#mark_as_paid" do
    context "when successful" do
      use_vcr_cassette "invoice/mark_as_paid/success"#, :record => :all

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

      before do
        invoice.create_and_send
        invoice.payment = OtherPaymentDetails.new({
          :method => 'Cash',
          :date => Date.today
        })
      end

      subject { invoice.mark_as_paid }

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
    end

    context "when failure" do
      use_vcr_cassette "invoice/mark_as_paid/failure"#, :record => :all

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

      before do
        invoice.create
        invoice.payment = nil
      end

      subject { invoice.mark_as_paid }

      its(:success?) { should be_false }
      its(:valid?) { should be_false }
      its(:errors) { should_not be_empty }
    end
  end
end