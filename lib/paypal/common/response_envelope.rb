module PayPal::Common
  class ResponseEnvelope
    include PayPal::Common::Base

    attr_accessor :timestamp
    attr_accessor :ack
    attr_accessor :build
    attr_accessor :correlation_id

    def success?
      self.ack == 'Success'
    end

    def set_timestamp(value)
      self.timestamp = Time.parse(value)
    rescue
    end
  end
end