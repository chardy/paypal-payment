module PayPal::AdaptivePayments
  class ReceiverList
    include PayPal::Common::Base

    attr_accessor :receiver

    def after_initialize
      super
      @receiver ||= []
    end

    def receivers
      @receiver
    end

    def receivers=(receivers)
      @receiver = receivers
    end

    def first
      self.receiver.first
    end

    # Set the only receiver
    #
    def only(user)
      self.receiver = [user]
    end

    # Replace receiver in list. It will add receiver into the list if receiver is not already in the list.
    #
    def replace(user)
      remove(user)
      add(user)
    end

    # Add receiver to list. It will ignore if the receiver is already in the list.
    #
    def add(user)
      self.receiver << user unless self.receivers.detect {|r| r.email == user.email }
    end

    # Remove receiver from list.
    #
    def remove(user)
      self.receiver.delete_if{ |r| r.email == user.email }
    end
  end
end