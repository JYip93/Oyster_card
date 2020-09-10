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
    no_touch_out
    raise "Minimum amount to travel is GBP1" if @balance < MINIMUM_BALANCE
    @journey.start(entry_station)
    @current_trip = @journey.journey_progress
  end

  # @history
  def touch_out(exit_station)
    @journey.finish(exit_station)
    @current_trip = @journey.journey_progress
    deduct(journey.fare)
    #@journey = nil
  end

  def in_journey?
    !@journey.nil?
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

  def no_touch_out
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
