module PayPal::Invoice
  module Response
    require "paypal/invoice/response/invoice"
    require "paypal/invoice/response/details"
    require "paypal/invoice/response/search"

    RESPONDERS = {
      :create               => "Invoice",
      :send                 => "Invoice",
      :create_and_send      => "Invoice",
      :update               => "Invoice",
      :cancel               => "Invoice",
      :mark_as_paid         => "Invoice",
      :mark_as_unpaid       => "Invoice",
      :mark_as_refunded     => "Invoice",
      :details              => "Details",
      :search               => "Search"
    }

    def self.process(method, response)
      response_class = PayPal::Invoice::Response.const_get(RESPONDERS[method])
      if response.respond_to?(:body_str)
        response_class.new(MultiJson.load(response.body_str))
      end
    end
  end
end