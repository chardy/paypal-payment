require "spec_helper"

class PaymentsTest < PayPal::ExpressCheckout::Response::Base
  has_many :payments
end
class PaymentItemsTest < PayPal::ExpressCheckout::Response::Base
  has_many :payment_items
end
class ShippingOptionsTest < PayPal::ExpressCheckout::Response::Base
  has_many :shipping_options
end
class BillingsTest < PayPal::ExpressCheckout::Response::Base
  has_many :billings
end
class FmfsTest < PayPal::ExpressCheckout::Response::Base
  has_many :fmfs
end

shared_examples_for "setting the correct values" do
  it "should set the correct values" do
    subject.send(association).each_with_index do |item, index|
      attribute_list.first.keys.each do |field|
        items[index].send(field).should eql(item.send(field))
      end
    end
  end
end

def build_item_str(items, prefix, suffix, attribute_list, item_fields)
  items.each_with_index.map do |item, idx|
    item_prefix = prefix.gsub(/n/, idx.to_s)
    item_suffix = suffix.gsub(/n/, idx.to_s)
    attribute_list.first.keys.map do |field|
      "#{item_prefix}#{item_fields[field]}#{item_suffix}=#{item.send(field)}"
    end.join("&")
  end.join('&')
end

describe PayPal::ExpressCheckout::Response::Base do
  let(:prefix) { "L_" }
  let(:suffix) { "n" }
  let(:response) { MockResponse.new(body_str) }
  let(:body_str) { "ACK=Success&" + items_str }
  let(:items) { attribute_list.map { |attributes| item_class.new(attributes) } }
  let(:item_fields) { PayPal::ExpressCheckout::Fields::ASSOCIATIONS[association] }
  let(:items_str) { build_item_str(items, prefix, suffix, attribute_list, item_fields) }
  let(:payment_item_attribute_list) {
    [
      [
        {
          :item_url       => "http://example.com/item/1",
          :number         => "1",
          :name           => "MacBook Air 11'",
          :amount         => "1150.0",
          :currency       => "USD",
          :item_category  => "Physical"
        },
        {
          :item_url       => "http://example.com/item/2",
          :number         => "2",
          :name           => "MacBook Air 13'",
          :amount         => "1350.0",
          :currency       => "USD",
          :item_category  => "Physical"
        }
      ],
      [
        {
          :item_url       => "http://example.com/item/10",
          :number         => "1",
          :name           => "MacBook Pro 13'",
          :amount         => "1350.0",
          :currency       => "USD",
          :item_category  => "Physical"
        },
        {
          :item_url       => "http://example.com/item/11",
          :number         => "2",
          :name           => "MacBook Air 15'",
          :amount         => "1550.0",
          :currency       => "USD",
          :item_category  => "Physical"
        }
      ],
      [
        {
          :item_url       => "http://example.com/item/20",
          :number         => "1",
          :name           => "iPad 2",
          :amount         => "550.0",
          :currency       => "USD",
          :item_category  => "Physical"
        },
        {
          :item_url       => "http://example.com/item/21",
          :number         => "2",
          :name           => "iPad mini'",
          :amount         => "350.0",
          :currency       => "USD",
          :item_category  => "Physical"
        }
      ],

    ]
  }

  describe "#build_payments" do
    let(:item_class) { PayPal::ExpressCheckout::Payment }
    let(:association) { :payments }
    let(:attribute_list) {
      [
        { :amount => "2500.0", :currency => "USD", :payment_action => "Sale" },
        { :amount => "2900.0", :currency => "USD", :payment_action => "Sale" },
        { :amount => "900.0",  :currency => "USD", :payment_action => "Sale" }
      ]
    }
    let(:prefix) { "PAYMENTREQUEST_n_" }
    let(:suffix) { "" }

    subject { PaymentsTest.new(response) }

    its(:payments) { should have(3).items }

    it_behaves_like "setting the correct values"

    context "with payment_items" do
      let(:payment_item_class) { PayPal::ExpressCheckout::PaymentItem }
      let(:payment_items) {
        payment_item_attribute_list.map do |group|
          group.map { |attributes| payment_item_class.new(attributes) }
        end
      }
      let(:payment_item_fields) { PayPal::ExpressCheckout::Fields::ASSOCIATIONS[:payment_items] }
      let(:payment_item_suffix) { "n" }
      let(:payment_item_str) {
        items.each_with_index.map do |item, index|
          build_item_str(
            payment_items[index],
            "L_#{prefix}".gsub(/n/, index.to_s),
            payment_item_suffix,
            payment_item_attribute_list[index],
            payment_item_fields
          )
        end.join("&")
      }
      let(:items_str) {
        build_item_str(items, prefix, suffix, attribute_list, item_fields) + "&" +
        payment_item_str
      }

      subject { PaymentsTest.new(response) }

      its(:payments) { should have(3).items }

      it "should have payment items and set the correct values" do
        subject.payments.each_with_index do |payment, index|
          payment.payment_items.size.should eql(payment_items[index].size)
          payment.payment_items.each_with_index do |payment_item, item_index|
            item_attributes = payment_item_attribute_list[index][item_index]
            item_attributes.keys.each do |key|
              payment_item.send(key).should eql(payment_item_attribute_list[index][item_index][key])
            end
          end
        end
      end
    end
  end

  describe "#build_shiping_options" do
    let(:item_class) { PayPal::ExpressCheckout::ShippingOption }
    let(:association) { :shipping_options }
    let(:attribute_list) {
      [
        { :is_default => "0", :name => "AIR", :amount => "25.0" },
        { :is_default => "1", :name => "SEA", :amount => "15.0" }
      ]
    }

    subject { ShippingOptionsTest.new(response) }

    its(:shipping_options) { should have(2).items }

    it_behaves_like "setting the correct values"
  end

  describe "#build_payment_items" do
    let(:item_class) { PayPal::ExpressCheckout::PaymentItem }
    let(:association) { :payment_items }
    let(:attribute_list) { payment_item_attribute_list.first }

    subject { PaymentItemsTest.new(response) }

    its(:payment_items) { should have(2).items }

    it_behaves_like "setting the correct values"
  end

  describe "#build_billings" do
    let(:item_class) { PayPal::ExpressCheckout::Billing }
    let(:association) { :billings }
    let(:attribute_list) {
      [
        {
          :type           => "MerchantInitiatedBilling",
          :description    => "Info",
          :payment_type   => "Any"
        },
        {
          :type           => "MerchantInitiatedBillingSingleAgreement",
          :description    => "Info",
          :payment_type   => "InstantOnly"
        },
      ]
    }

    subject { BillingsTest.new(response) }

    its(:billings) { should have(2).items }

    it_behaves_like "setting the correct values"
  end

  describe "#fmfs" do
    let(:item_class) { PayPal::ExpressCheckout::Fmf }
    let(:association) { :fmfs }
    let(:attribute_list) {
      [
        {
          :pending_id     => "1",
          :pending_name   => "pending name",
          :report_id      => "2",
          :report_name    => "report name",
          :deny_id        => "3",
          :deny_name      => "deny name"
        },
        {
          :pending_id     => "4",
          :pending_name   => "pending 2 name",
          :report_id      => "5",
          :report_name    => "report 2 name",
          :deny_id        => "6",
          :deny_name      => "deny 2 name"
        }
      ]
    }

    subject { FmfsTest.new(response) }

    its(:fmfs) { should have(2).items }

    it_behaves_like "setting the correct values"
  end
end
