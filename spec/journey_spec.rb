require 'journey'

describe Journey do
  describe '#entry_station' do
    it 'returns the entry_station when called' do
      expect(Journey.new(entry_station: "Old Street").entry_station).to eq "Old Street"
    end
  end

  describe '#exit_station' do
    it 'returns the exit_station when called' do
      journey = Journey.new(entry_station: "station")
      journey.exit_station = "station2"
      expect(journey.exit_station).to eq "station2"
    end
  end

  describe '#fare' do
    it 'returns the minimum fare for the journey' do
      journey = Journey.new(entry_station: "station")
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "charges the penalty fare if you don't tap out" do
      journey = Journey.new(entry_station: "Penalty fare")
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it "charges the penalty fare if you don't tap in" do
      journey = Journey.new(entry_station: "station")
      journey.exit_station = "Penalty fare"
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end
