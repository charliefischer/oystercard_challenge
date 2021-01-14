require 'journey'
class JourneyLog

  def initialize(journey_class: )
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    Journey.new(entry_station)
  end


end
