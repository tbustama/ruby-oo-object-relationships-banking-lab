class Transfer
    attr_accessor :status
    attr_reader :sender, :receiver, :amount

    @@all = []
    
    def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
    end

    def valid? 
      if @receiver.valid? && @sender.valid?
        return true
      else
        return false
      end
    end

    def execute_transaction
      if !@@all.include?(self)
        if self.valid? && @sender.balance >= self.amount
          @sender.balance -= self.amount
          @receiver.deposit(self.amount)
          self.status = "complete"
          @@all << self
        else
          self.status = "rejected"
          return "Transaction rejected. Please check your account balance."
        end
      end
    end

    def reverse_transfer
      if @@all.include?(self)
        @sender.deposit(self.amount)
        @receiver.balance -= self.amount
        self.status = "reversed"
      end
    end


end