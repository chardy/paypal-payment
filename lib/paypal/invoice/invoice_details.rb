module PayPal::Invoice
  class InvoiceDetails < PayPal::Invoice::Base
    attr_accessor :status
    attr_accessor :total_amount
    attr_accessor :origin
    attr_accessor :created_date
    attr_accessor :created_by
    attr_accessor :canceled_date
    attr_accessor :canceled_by_actor
    attr_accessor :canceled_by
    attr_accessor :last_updated_date
    attr_accessor :last_updated_by
    attr_accessor :first_sent_date
    attr_accessor :last_sent_date
    attr_accessor :last_sent_by
    attr_accessor :paid_date

    def set_created_date(value)
      self.created_date = build_datetime(value)
    end

    def set_canceled_date(value)
      self.canceled_date = build_datetime(value)
    end

    def set_last_updated_date(value)
      self.last_updated_date = build_datetime(value)
    end

    def set_first_sent_date(value)
      self.first_sent_date = build_datetime(value)
    end

    def set_last_sent_date(value)
      self.last_sent_date = build_datetime(value)
    end
  end
end