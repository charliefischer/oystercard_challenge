# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:station_name) { double :Station_name }
  let(:station2_name) { double :Station_name }
  let(:journey) { { entry_station: station_name, exit_station: station2_name } }
  let(:journey_class_double) { double :journey_class}
  describe '#balance' do
    it 'should check a card has a balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should top up balance' do
      expect { subject.top_up(20) }.to change { subject.balance }.by 20
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error 'Maximum balance of #{maximum_balance} exceeded'
    end
  end

  describe '#touch_in' do
    it 'should touch in oystercard' do
      subject.top_up(5)
      expect(subject.touch_in(station_name).entry_station).to eq station_name
    end
    it 'should raise an error if balance is less than 1' do
      expect { subject.touch_in(station_name) }.to raise_error 'No money'
    end
  end

  describe '#in_journey' do
    it 'should check if oystercard is in_journey?' do
      subject.top_up(5)
      subject.touch_in(station_name)
      expect(subject.in_journey?).to eq(true)
    end
  end

  describe '#touch_out' do
    it 'should touch out oystercard' do
      subject.top_up(5)
      subject.touch_in(station_name)
      expect(subject.touch_out(station2_name)).to eq nil
    end
    it 'should take off minimum cost when touching out' do
      subject.top_up(5)
      subject.touch_in(station_name)
      expect { subject.touch_out(station2_name) }.to change { subject.balance }.by(-Journey::MINIMUM_FARE)
    end
  end

  describe '#entry_station' do
    it 'oystercard should have current_journey value of nil after journey is complete' do
      subject.top_up(5)
      subject.touch_in(station_name)
      subject.touch_out(station2_name)
      expect(subject.current_journey).to eq nil
    end
    it 'should state the name of station you have travelled from' do
      subject.top_up(5)
      subject.touch_in(station_name)
      expect(subject.current_journey.entry_station).to eq(station_name)
    end
  end

  describe '#exit_station' do
    it 'will return the station_name on exit' do
      subject.top_up(5)
      subject.touch_in(station_name)
      subject.touch_out(station2_name)
      expect(subject.journeys[-1].exit_station).to eq(station2_name)
    end
  end

  describe '#journeys' do
    it 'will return an empty hash by default' do
      expect(subject.journeys).to eq([])
    end

    it 'will return the station in the journey' do
      subject.journeys << journey_class_double
      expect(subject.journeys).to include journey_class_double
    end
  end
end
