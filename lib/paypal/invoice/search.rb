module PayPal::Invoice
  class Search < PayPal::Invoice::Base

    attr_accessor :merchant_email
    attr_accessor :parameters
    attr_accessor :page
    attr_accessor :page_size

    attr_accessor :response

    def set_parameters(value)
      self.parameters = build_value(SearchParameters, value)
    end

    def search
      self.response = Response.process(:search, request.run(:search, self.to_hash))
    end
  end
end