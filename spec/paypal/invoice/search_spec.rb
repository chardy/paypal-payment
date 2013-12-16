require "spec_helper"

include PayPal::Invoice

describe PayPal::Invoice::Search do
  describe "#search" do
    context "when successful" do
      use_vcr_cassette "invoice/search/success"#, :record => :all

      before do
        invoice_1.create
        invoice_2.create
      end

      let(:invoice_1) {
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
      let(:invoice_2) {
        PayPal::Invoice::Invoice.new(
          :merchant_email => 'chardy_1345003248_per@gmail.com',
          :payer_email => 'chardy_1345003165_per@gmail.com',
          :item_list => {
            :item => [
              {
                :name => 'iPad mini',
                :quantity => 2,
                :unit_price => 300.0
              }
            ]
          },
          :currency_code => 'AUD',
          :payment_terms => 'Net10'
        )
      }
      let(:search) {
        PayPal::Invoice::Search.new(
          :merchant_email => 'chardy_1345003248_per@gmail.com',
          :parameters => {
            :currency_code => 'AUD'
          },
          :page => 1,
          :page_size => 10
        )
      }


      subject { search.search }

      it "invoice_list should include the right invoice" do
        subject.invoice_list.invoice.first.invoice_id.should eql(invoice_2.invoice_id)
      end
      its(:success?) { should be_true }
      its(:valid?) { should be_true }
    end
  end
end