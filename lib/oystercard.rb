class Oystercard

  MAXIMUM_BALANCE = 90 

  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_travel, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end 

  def touch_in (station_name)
    fail "No money" if balance < 1
    @entry_station = station_name
  end 

  def in_journey?
  @entry_station != nil
  end
  
  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end