# frozen_string_literal: true
require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90

  attr_reader :balance, :in_travel, :journeys, :current_journey

  def initialize
    @balance = 0
    @current_journey = nil
    @journeys = []
  end

  def top_up(amount)
    raise 'Maximum balance of #{maximum_balance} exceeded' if  (amount + balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_name)
    raise 'No money' if balance < 1
    touch_out("Penalty fare") if in_journey?
    start_new_journey(station_name)
  end

  def in_journey?
    @current_journey != nil
  end

  def touch_out(station_name)
    start_new_journey("Penalty fare") if !in_journey?
    @current_journey.exit_station = station_name
    end_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def start_new_journey(station_name)
    @current_journey = Journey.new(station_name)
  end

  def end_journey
    deduct(current_journey.fare)
    @journeys << current_journey
    @current_journey = nil
  end
end
