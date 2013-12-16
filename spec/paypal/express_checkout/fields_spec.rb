require 'spec_helper'

class FieldsTestHarness
  include PayPal::ExpressCheckout::Fields
end

class AssociationTestHarness
  include PayPal::ExpressCheckout::Fields
end

class SuperTestHarness
  include PayPal::ExpressCheckout::Fields

  has_fields :payer

  has_many :shipping_options
end

class SubTestHarness < SuperTestHarness
  has_fields :amount

  has_many :payment_items
end

describe PayPal::ExpressCheckout::Fields do
  describe "##has_fields" do
    before { FieldsTestHarness.has_fields(:checkout, :buyer) }

    subject { FieldsTestHarness.new }

    [:checkout, :buyer].each do |group|
      PayPal::ExpressCheckout::Fields::ATTRIBUTES[group].each_key do |field|
        its(:methods) { should include(field) }
      end
    end
  end

  describe "##field_map" do
    let(:model) { FieldsTestHarness }
    let(:value) { PayPal::ExpressCheckout::Fields::ATTRIBUTES[:shipping_option][:amount] }

    before do
      model.has_fields(:payer, :shipping_option)
    end

    subject { model.field_map }

    [:payer, :shipping_option].each do |group|
      PayPal::ExpressCheckout::Fields::ATTRIBUTES[group].each_key do |field|
        it { should have_key(field) }
      end
    end

    it "should return the correct value" do
      subject[:amount].should eql(value)
    end

    context "with associations" do
      let(:model) { AssociationTestHarness }

      before do
        model.has_many(:shipping_options)
      end

      it "should return the correct value" do
        subject[:shipping_options].should eql(PayPal::ExpressCheckout::Fields::ASSOCIATIONS[:shipping_options])
      end
    end
  end

  describe "##has_many" do
    before { FieldsTestHarness.has_many(:shipping_options) }

    subject { FieldsTestHarness.new }

    [:shipping_options].each do |association|
      its(:methods) { should include(association) }

      it "should return empty array for associations" do
        subject.shipping_options.should eql([])
      end
    end
  end

  describe "#collect_group" do
    let(:field_count) {
      PayPal::ExpressCheckout::Fields::ATTRIBUTES[:amount].size +
      PayPal::ExpressCheckout::Fields::ATTRIBUTES[:credit_card].size + 1
    }

    before do
      AssociationTestHarness.has_fields(:amount, :credit_card)
      AssociationTestHarness.has_many(:shipping_options)
    end

    subject { AssociationTestHarness.new.group_fields(:amount, :credit_card, :shipping_options) }

    its(:count) { should eql(field_count) }
  end

  describe "inheritance" do
    describe "super class" do
      subject { SuperTestHarness.new }

      [:payer_id, :email].each do |field|
        its(:methods) { should include(field) }
      end
      [:amount, :fee_amount].each do |field|
        its(:methods) { should_not include(field) }
      end
      [:shipping_options].each do |association|
        its(:methods) { should include(association) }
      end
      [:payment_items].each do |association|
        its(:methods) { should_not include(association) }
      end
    end

    describe "subclass" do
      subject { SubTestHarness.new }

      [:payer_id, :email, :amount, :fee_amount].each do |field|
        its(:methods) { should include(field) }
      end
      [:shipping_options, :payment_items].each do |association|
        its(:methods) { should include(association) }
      end

      describe "#field_map" do
        subject { SubTestHarness.field_map }

        [:payer_id, :email, :amount, :fee_amount].each do |field|
          it { should have_key(field) }
        end
      end
    end
  end
end