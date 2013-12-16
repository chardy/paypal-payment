

module PayPal::Common
  module Response
    include PayPal::Common::Base

    attr_accessor :error
    attr_accessor :response_envelope

    def set_response_envelope(value)
      self.response_envelope = ResponseEnvelope.new(value)
    end

    def errors
      @error||[]
    end

    def set_error(value)
      self.error = build_value(ErrorData, value)
    end

    def response_envelope
      @response_envelope ||= ResponseEnvelope.new
    end

    def success?
      self.response_envelope.success?
    end

    def valid?
      (self.errors||[]).empty?
    end
  end
end