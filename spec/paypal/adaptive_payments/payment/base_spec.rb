require "spec_helper"

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::Payment do
  let(:receiver_email) { 'chardy_1345003248_per@gmail.com' }
  let(:receiver) { Receiver.new(:email => receiver_email, :amount => 10.0) }
  let(:receiver_list) { ReceiverList.new(:receivers => [receiver]) }

  describe "#receiver=" do

    it "add receiver to receiver_list" do
      subject.receiver = receiver
      subject.receiver_list.receivers.should have(1).item
      subject.receiver_list.first.should eql(receiver)
    end
  end

  describe "#receiver" do
    let(:receiver) { Receiver.new(:email => receiver_email) }

    before { subject.receiver_list = receiver_list }

    it "returns the first receiver" do
      subject.receiver.should eql(receiver)
    end
  end
end