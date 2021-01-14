require 'journey_log'


describe JourneyLog do

  let(:journey){ double :journey }
  let(:station){ double :station }
  let(:journey_class){ double :journey_class, new: journey}
  subject {described_class.new(journey_class: journey_class)}

  describe '#start_journey' do
    it 'starts a journey' do 
      expect(journey_class).to receive(:new).with(entry_station: station)
      journey_class.new(station)
      subject.start(station)
    end
  end 

end
