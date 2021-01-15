require 'journey'

describe Journey do
  subject { Journey.new("Chalfont")}

  describe '#entry_station' do
    it 'returns entry_station when called' do
      expect(subject.entry_station).to eq "Chalfont"
    end
  end

  describe '#exit_station' do
    it 'returns exit_station when called' do
      journey = Journey.new("Chalfont")
      journey.exit_station = "Hammersmith"
      expect(journey.exit_station).to eq "Hammersmith"
    end
  end

  describe '#fare' do
    it 'return minimum fare for the journey' do
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end

    it 'returns penalty fare if user did not tap out' do
      journey = Journey.new("Penalty fare")
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns penalty fare if user did not tap in' do
      subject.exit_station = "Penalty fare"
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
      
  end
end