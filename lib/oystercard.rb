class Oystercard

  MAXIMUM_BALANCE = 90

  MINIMUM_CHARGE = 1

  attr_reader :balance, :in_travel, :entry_station,
    :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = {}
  end

  def top_up(amount)
    fail 'Maximum balance of #{maximum_balance} exceeded' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in (station_name)
    fail "No money" if balance < 1
    @journeys[:entry] = station_name
    @entry_station = station_name
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_out(station_name)
    deduct(MINIMUM_CHARGE)
    @exit_station = station_name
    @journeys[:exit] = station_name
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
