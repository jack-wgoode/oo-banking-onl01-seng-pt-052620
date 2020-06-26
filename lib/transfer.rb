class Transfer
  
  attr_accessor :sender, :receiver, :status, :amount, :balance
  
  @@all = []
  
  def initialize(account_name1, account_name2, amount)
    @sender = account_name1
    @receiver = account_name2
    @status = "pending"
    @amount = amount
  end 
  
  def valid?
    @sender.valid? && @receiver.valid? && self.status != "complete"
  end
  
  def insufficient_funds?
    self.valid && @sender.balance >= self.amount
  end
  
  def execute_transaction 
    if self.valid? && self.status == "pending"
       self.sender.withdraw(amount)
       self.receiver.deposit(amount)
       self.status = "complete"
       @@all << self
     elsif self.insufficient_funds? 
     self.status = "rejected"
     "Transaction rejected. Please check your account balance."
    end
   end    
  
end
