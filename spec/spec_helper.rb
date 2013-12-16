require "bundler"
Bundler.setup(:default, :development)
Bundler.require

require "paypal-payment"
require "vcr"
require "webmock/rspec"

VCR.configure do |config|
  config.cassette_library_dir = File.dirname(__FILE__) + "/fixtures"
  config.hook_into :webmock
  config.default_cassette_options = { :serialize_with => :syck }
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  config.before do
    PayPal::Api.configure do |config|
      config.sandbox    = true
      config.username   = "chardy_api1.gmail.com"
      config.password   = "8DTSWBZC7GDR3T4X"
      config.signature  = "AG-8mOpuFhFyFOYHlaTUYn3Syf15AWJKRnfHMVsmCtC3DK51-ENEPqLS"
      config.seller_id  = "GCK9DAQBWTUHQ"
      config.email      = "chardy_1345003248_per@gmail.com"
    end
  end
end

class MockResponse
  attr_accessor :body_str
  def initialize(body)
    self.body_str = body
  end
end
