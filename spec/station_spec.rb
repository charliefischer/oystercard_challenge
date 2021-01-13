require 'station'

describe Station do
  describe '#zone' do
    it 'will return the zone number' do
      station = Station.new("Cockfosters")
      expect(station.zone).to eq 5
    end 
  end
end
