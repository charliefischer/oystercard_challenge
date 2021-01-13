require 'station'

describe Station do
subject {described_class.new("Old Street",1)}
  describe '#zone' do
    it 'will return the zone number' do
      expect(subject.zone).to eq 1
    end
    it 'will return the station name' do
      expect(subject.name).to eq "Old Street"
  end
end
end
