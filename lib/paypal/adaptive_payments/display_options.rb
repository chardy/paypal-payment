module PayPal::AdaptivePayments
  class DisplayOptions
    include PayPal::Common::Base

    attr_accessor :email_header_image_url
    attr_accessor :email_marketing_image_url
    attr_accessor :header_image_url
    attr_accessor :business_name
  end
end