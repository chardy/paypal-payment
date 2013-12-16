require "spec_helper"

class SimpleTestHarness
  include PayPal::Common::Base

  attr_accessor :name, :email, :number, :phone
end

class PhoneTestHarness
  include PayPal::Common::Base

  attr_accessor :number, :country_code
end

class DeepTestHarness
  include PayPal::Common::Base

  attr_accessor :name, :receivers

  def set_receivers(value)
    self.receivers = build_value(SimpleTestHarness, value)
  end
end

class ResponseTestHarness
  include PayPal::Common::Base

  attr_accessor :timestamp, :ack

  def set_timestamp(value)
    self.timestamp = Time.parse(value)
  rescue
  end
end

describe PayPal::Common::Base do
  let(:name) { "Peter" }
  let(:email) { "peter@spiderman.com" }
  let(:number) { "12345" }
  let(:attributes) { {:name => name, :email => email, :number => number} }
  let(:phone_attrs) { {:number => "98765432", :country_code => "65"} }
  let(:phone) { PhoneTestHarness.new(phone_attrs) }
  let(:simple) { SimpleTestHarness.new(attributes.merge(:phone => phone)) }
  let(:deep) { DeepTestHarness.new(:name => "deep test", :receivers => [simple]) }

  describe "#initialize" do
    subject { simple }

    it "sets attributes" do
      subject.name.should eql(name)
      subject.email.should eql(email)
      subject.number.should eql(number)
      subject.phone.should eql(phone)
    end

    context "with camel case keys" do
      subject { PhoneTestHarness.new('number' => '98765432', 'countryCode' => '65') }

      it "sets attributes" do
        subject.number.should eql('98765432')
        subject.country_code.should eql('65')
      end
    end

    context "with array value" do

      it "build_value" do
        DeepTestHarness.any_instance.should_receive(:build_value).with(SimpleTestHarness, [attributes, attributes])
        DeepTestHarness.new(:name => "deep test", :receivers => [attributes, attributes])
      end
    end

    context "with set_<attribute> method" do
      subject { ResponseTestHarness.new('ack' => 'Success', 'timestamp' => '2013-01-03T22:10:56.934-08:00') }

      it "sets attributes" do
        subject.timestamp.is_a?(Time)
      end
    end
  end

  describe "#build_value" do
    subject { DeepTestHarness.new.build_value(PhoneTestHarness, [phone_attrs, phone_attrs]) }

    its(:size) { should eql(2) }
    its(:first) { should be_a(PhoneTestHarness) }
  end

  describe "#camelize" do
    let(:term) { "starting_date" }
    let(:upper_case) { false }

    subject { SimpleTestHarness.new.camelize(term, upper_case) }

    it { should eql("startingDate") }
  end

  describe "#to_hash" do
    subject { simple.to_hash }

    it "has all keys" do
      subject.should have_key(:name)
      subject.should have_key(:email)
      subject.should have_key(:number)
      subject.should have_key(:phone)
    end

    it "sets all values" do
      subject[:name].should eql(name)
      subject[:email].should eql(email)
      subject[:number].should eql(number)
      subject[:phone].should eql({:number => "98765432", :countryCode => "65"})
    end

    context "with parameters" do
      subject { simple.to_hash(:name, :email) }

      it "only has selected keys" do
        subject.should have_key(:name)
        subject.should have_key(:email)
        subject.should_not have_key(:number)
        subject.should_not have_key(:phone)
      end

      it "only sets selected values" do
        subject[:name].should eql(name)
        subject[:email].should eql(email)
        subject[:number].should be_nil
        subject[:phone].should be_nil
      end
    end

    context "deep" do
      subject { deep.to_hash }

      it "has object hash" do
        subject[:receivers].should eql([attributes.merge(:phone => {:number => "98765432", :countryCode => "65"})])
      end
    end
  end

  describe "#to_json" do
    subject { simple.to_json }

    it "outputs json" do
      subject.should eql("{\"name\":\"Peter\",\"email\":\"peter@spiderman.com\",\"number\":\"12345\",\"phone\":{\"number\":\"98765432\",\"countryCode\":\"65\"}}" )
    end

    context "with parameters" do
      subject { simple.to_json(:name, :email) }

      it "only outputs selected attributes" do
        subject.should eql("{\"name\":\"Peter\",\"email\":\"peter@spiderman.com\"}" )
      end
    end
  end
end