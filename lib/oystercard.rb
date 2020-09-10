require_relative "journey"

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :history, :journey, :current_trip

  LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize(balance = 0, journey = Journey.new)
    @balance = balance
    @history = []
    @current_trip = nil
    @journey = journey
  end

  def top_up(amount)
    fail "Card reached the GBP#{LIMIT} limit" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    did_not_touch_out
    raise "Minimum amount to travel is GBP1" if @balance < MINIMUM_BALANCE
    @journey.start(entry_station)
    store_current_trip
  end

  def touch_out(exit_station)
    @journey.finish(exit_station)
    store_current_trip
    deduct(journey.fare)
    sucessfull_trip
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def journey_reset
    @history << current_trip
    @current_trip = nil
    journey.reset_hash
  end

  def sucessfull_trip
    if current_trip["entry_station"] != nil && current_trip["exit_station"] != nil
      journey_reset
    end
  end

  def store_current_trip
    @current_trip = @journey.journey_progress
  end

  def did_not_touch_out
    if @current_trip != nil
      if current_trip["entry_station"] != nil && current_trip["exit_station"] == nil
        deduct(journey.fare)
        journey_reset
      else
        journey_reset
      end
    end
  end
end
