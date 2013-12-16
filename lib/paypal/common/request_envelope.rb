module PayPal::Common
  class RequestEnvelope
    include PayPal::Common::Base

    attr_accessor :error_language
    attr_accessor :detail_level

    def after_initialize
      @error_language ||= 'en_US'
      @detail_level ||= 'ReturnAll'
    end
  end
end