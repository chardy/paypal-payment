module PayPal::AdaptivePayments
  class ClientDetails
    include PayPal::Common::Base

    attr_accessor :application_id
    attr_accessor :customer_id
    attr_accessor :customer_type
    attr_accessor :device_id
    attr_accessor :geo_location
    attr_accessor :ip_address
    attr_accessor :model
    attr_accessor :partner_name
  end
end