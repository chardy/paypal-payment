require "cgi"
require "uri"
require "ostruct"
require "time"

module PayPal
  module ExpressCheckout
    class Base
      include PayPal::ExpressCheckout::Fields

      def initialize(options = {})
        options.each {|name, value| send("#{name}=", value)}
      end

      # Just a shortcut convenience.
      #
      def request # :nodoc:
        @request ||= PayPal::ExpressCheckout::Request.new
      end

      def run(method, params = {}, headers = {})
        request.run(self, method, params, headers)
      end

      private
      # Collect specified attributes and build a hash out of it.
      #
      def collect(*args) # :nodoc:
        args.inject({}) do |buffer, attr_name|
          value = send(attr_name)
          buffer[attr_name] = value if value
          buffer
        end
      end
    end
  end
end