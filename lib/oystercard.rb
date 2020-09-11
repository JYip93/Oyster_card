require_relative "journey"
require_relative "journey_log"

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey

  LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  def initialize(balance = 0, journeylog = JourneyLog.new)
    @balance = balance
    @journeylog = journeylog

  end

  def top_up(amount)
    fail "Card reached the GBP#{LIMIT} limit" if @balance + amount > LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    did_not_touch_out
    raise "Minimum amount to travel is GBP1" if @balance < MINIMUM_BALANCE
    @journeylog.start(entry_station)
    @journeylog.store_journey
  end

  def touch_out(exit_station)
    @journeylog.finish(exit_station)
    @journeylog.store_journey
    deduct(@journeylog.fare)
    sucessfull_trip
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def journey_reset
    @journeylog.history << @journeylog.current_trip
    @journeylog.current_trip = nil
    @journeylog.journey.reset_hash
  end

  def sucessfull_trip
    if @journeylog.current_trip["entry_station"] != nil && @journeylog.current_trip["exit_station"] != nil
      journey_reset
    end
  end

  #def store_current_trip
  # @current_trip = @journey.journey_progress
  #end

  def did_not_touch_out
    if @journeylog.current_trip != nil
      if @journeylog.current_trip["entry_station"] != nil && @journeylog.current_trip["exit_station"] == nil
        deduct(@journeylog.journey.fare)
        journey_reset
      else
        journey_reset
      end
    end
  end
end
