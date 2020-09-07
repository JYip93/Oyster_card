class Oystercard
  attr_reader :balance

LIMIT = 90

  def initialize(balance=0)
    @balance = balance
  end

  def top_up(amount)
    fail "Card reached the £#{LIMIT} limit" if @balance + amount > LIMIT
    @balance + amount
  end

end