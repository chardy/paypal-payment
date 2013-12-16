require 'spec_helper'

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::Preapproval do
  let(:starting_date) { Date.today }

  describe "#create" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/preapproval/create/success"#, :record => :all

      let(:preapproval) {
        Preapproval.new(
          :client_details => {
            :ip_address => "234.8.8.18",
            :device_id => "123456",
            :application_id => "PP"
          },
          :starting_date => starting_date,
          :currency_code => 'USD',
          :max_total_amount_of_all_payments => 2000.0,
          :cancel_url => 'http://dss.example.com/cancel?preapprovalkey=${preapprovalkey}',
          :return_url => 'http://dss.example.com/accepted?preapprovalkey=${preapprovalkey}'
        )
      }

      subject { preapproval.create }

      before { subject }

      it "sets preapproval_key" do
        preapproval.preapproval_key.should eql(subject.preapproval_key)
      end
      its(:success?) { should be_true }
      its(:preapproval_key) { should_not be_nil }
      its(:preapproval_url) { should eql("https://www.sandbox.paypal.com/webscr?cmd=_ap-preapproval&preapprovalkey=#{preapproval.preapproval_key}") }
    end
  end
end