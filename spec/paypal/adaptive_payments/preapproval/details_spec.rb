require 'spec_helper'

include PayPal::AdaptivePayments

describe PayPal::AdaptivePayments::Preapproval do
  let(:starting_date) { Date.today }

  describe "#details" do
    context "when successful" do
      use_vcr_cassette "adaptive_payments/preapproval/details/success"#, :record => :all

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
          :cancel_url => 'http://example.com/cancel',
          :return_url => 'http://example.com/return'
        )
      }

      before { preapproval.create }

      subject { preapproval.details }

      its(:success?) { should be_true }
    end
  end
end