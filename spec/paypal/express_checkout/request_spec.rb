require "spec_helper"

describe PayPal::ExpressCheckout::Request do
  describe "#normalize_params" do
    let(:request) { PayPal::ExpressCheckout::Request.new }
    let(:object) { nil }
    let(:params) { {} }

    subject { request.normalize_params(object, params) }

    context "with survey_choices" do
      let(:object) { PayPal::ExpressCheckout::Checkout.new }
      let(:params) {
        {
          :survey_choices => [
            'Very Good',
            'Good',
            'Average',
            'Below Average',
            'Bad'
          ]
        }
      }
      let(:expected) {
        {
          :L_SURVEYCHOICE0 => 'Very Good',
          :L_SURVEYCHOICE1 => 'Good',
          :L_SURVEYCHOICE2 => 'Average',
          :L_SURVEYCHOICE3 => 'Below Average',
          :L_SURVEYCHOICE4 => 'Bad'
        }
      }

      it { should eql(expected) }
    end

    context "with shipping_options" do
      let(:object) { PayPal::ExpressCheckout::Checkout.new }
      let(:params) {
        {
          :shipping_options => [
            ShippingOption.new({
              :is_default => true,
              :name => "AIR",
              :amount => 50.0
            }),
            ShippingOption.new({
              :is_default => false,
              :name => "SEA",
              :amount => 25.0
            })
          ]
        }
      }
      let(:expected) {
        {
          :L_SHIPPINGOPTIONISDEFAULT0 => true,
          :L_SHIPPINGOPTIONNAME0 => "AIR",
          :L_SHIPPINGOPTIONAMOUNT0 => 50.0,
          :L_SHIPPINGOPTIONISDEFAULT1 => false,
          :L_SHIPPINGOPTIONNAME1 => "SEA",
          :L_SHIPPINGOPTIONAMOUNT1 => 25.0
        }
      }

      it { should eql(expected) }
    end

    context "with payment_items" do
      let(:object) { PayPal::ExpressCheckout::Payment.new }
      let(:params) {
        {
          :payment_items => [
            PaymentItem.new({
              :number => 1,
              :name => "iPhone 5",
              :description => "Best iPhone ever",
              :quantity => 1,
              :amount => 499,
              :tax_amount => 2.49,
              :item_category => "Phone"
            }),
            PaymentItem.new({
              :number => 1,
              :name => "iPhone 4S",
              :description => "Siri",
              :quantity => 1,
              :amount => 399,
              :tax_amount => 1.99,
              :item_category => "Phone"
            })
          ]
        }
      }
      let(:expected) {
        {
          :L_ITEMCATEGORY0 => "Phone",
          :L_NAME0 => "iPhone 5",
          :L_DESC0 => "Best iPhone ever",
          :L_AMT0 => 499,
          :L_NUMBER0 => 1,
          :L_QTY0 => 1,
          :L_TAXAMT0 => 2.49,
          :L_ITEMCATEGORY1 => "Phone",
          :L_NAME1 => "iPhone 4S",
          :L_DESC1 => "Siri",
          :L_AMT1 => 399,
          :L_NUMBER1 => 1,
          :L_QTY1 => 1,
          :L_TAXAMT1 => 1.99
        }
      }

      it { should eql(expected) }
    end

    context "with payments" do
      let(:object) { PayPal::ExpressCheckout::Checkout.new }
      let(:params) {
        {
          :payments => [
            PayPal::ExpressCheckout::Payment.new({
              :invoice_num => "12345",
              :description => "iPhones",
              :note_text => "Some notes",
              :amount => 998,
              :shipping_amount => 25,
              :tax_amount => 20.5,
              :currency => "USD",
              :ship_to_name => "John Lim",
              :ship_to_country => "SG",
              :payment_items => [
                PaymentItem.new({
                  :number => 1,
                  :name => "iPhone 5",
                  :description => "Best iPhone ever",
                  :quantity => 1,
                  :amount => 499,
                  :tax_amount => 12.25,
                  :item_category => "Physical"
                }),
                PaymentItem.new({
                  :number => 2,
                  :name => "iPhone 4S",
                  :description => "Siri",
                  :quantity => 1,
                  :amount => 399,
                  :tax_amount => 8.25,
                  :item_category => "Physical"
                })
              ]
            }),
            PayPal::ExpressCheckout::Payment.new({
              :invoice_num => "12346",
              :description => "Apple Gadgets",
              :note_text => "Some notes",
              :amount => 599,
              :shipping_amount => 25,
              :tax_amount => 12.5,
              :currency => "USD",
              :payment_items => [
                PaymentItem.new({
                  :number => 1,
                  :name => "iPad 4",
                  :description => "Best iPad ever",
                  :quantity => 1,
                  :amount => 599,
                  :tax_amount => 12.5,
                  :item_category => "Physical"
                })
              ]
            })
          ]
        }
      }
      let(:expected) {
        {
          :PAYMENTREQUEST_0_AMT => 998,
          :PAYMENTREQUEST_0_CURRENCYCODE => 'USD',
          :PAYMENTREQUEST_0_SHIPPINGAMT => 25,
          :PAYMENTREQUEST_0_TAXAMT => 20.5,
          :PAYMENTREQUEST_0_DESC => "iPhones",
          :PAYMENTREQUEST_0_INVNUM => "12345",
          :PAYMENTREQUEST_0_NOTETEXT => "Some notes",
          :PAYMENTREQUEST_0_SHIPTONAME => "John Lim",
          :PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE => "SG",
          :L_PAYMENTREQUEST_0_NAME0 => "iPhone 5",
          :L_PAYMENTREQUEST_0_DESC0 => "Best iPhone ever",
          :L_PAYMENTREQUEST_0_AMT0 => 499,
          :L_PAYMENTREQUEST_0_NUMBER0 => 1,
          :L_PAYMENTREQUEST_0_QTY0 => 1,
          :L_PAYMENTREQUEST_0_TAXAMT0 => 12.25,
          :L_PAYMENTREQUEST_0_ITEMCATEGORY0 => "Physical",
          :L_PAYMENTREQUEST_0_NAME1 => "iPhone 4S",
          :L_PAYMENTREQUEST_0_DESC1 => "Siri",
          :L_PAYMENTREQUEST_0_AMT1 => 399,
          :L_PAYMENTREQUEST_0_NUMBER1 => 2,
          :L_PAYMENTREQUEST_0_QTY1 => 1,
          :L_PAYMENTREQUEST_0_TAXAMT1 => 8.25,
          :L_PAYMENTREQUEST_0_ITEMCATEGORY1 => "Physical",
          :PAYMENTREQUEST_1_AMT => 599,
          :PAYMENTREQUEST_1_CURRENCYCODE => 'USD',
          :PAYMENTREQUEST_1_SHIPPINGAMT => 25,
          :PAYMENTREQUEST_1_TAXAMT => 12.5,
          :PAYMENTREQUEST_1_DESC => "Apple Gadgets",
          :PAYMENTREQUEST_1_INVNUM => "12346",
          :PAYMENTREQUEST_1_NOTETEXT => "Some notes",
          :L_PAYMENTREQUEST_1_NAME0 => "iPad 4",
          :L_PAYMENTREQUEST_1_DESC0 => "Best iPad ever",
          :L_PAYMENTREQUEST_1_AMT0 => 599,
          :L_PAYMENTREQUEST_1_NUMBER0 => 1,
          :L_PAYMENTREQUEST_1_QTY0 => 1,
          :L_PAYMENTREQUEST_1_TAXAMT0 => 12.5,
          :L_PAYMENTREQUEST_1_ITEMCATEGORY0 => "Physical",
        }
      }

      it { should eql(expected) }
    end
  end
end
