require "spec_helper"

include PayPal::Invoice

describe PayPal::Invoice::Invoice do
  describe "#mark_as_refunded" do
    context "when successful" do
      use_vcr_cassette "invoice/mark_as_refunded/success"

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
        invoice.mark_as_paid
        invoice.refund_detail = OtherPaymentDetails.new({
          :note => 'Refunded',
          :date => Date.today
        })
      end

      subject { invoice.mark_as_refunded }

      its(:success?) { should be_true }
      its(:valid?) { should be_true }
    end
  end
end