require "spec_helper"

describe PayPal::Common::RequestEnvelope do
  its(:error_language) { should eql('en_US') }
  its(:detail_level) { should eql('ReturnAll') }
end