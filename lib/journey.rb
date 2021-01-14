class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station
  attr_accessor :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def journey_complete?
    @exit_station != nil
  end

  def fare
    @exit_station == "Penalty fare" || @entry_station == "Penalty fare" ?
    PENALTY_FARE : MINIMUM_FARE
  end

end
