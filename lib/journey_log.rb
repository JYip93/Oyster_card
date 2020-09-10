require_relative "journey"

class JourneyLog
  attr_reader :journey

  def initialize(journey = Journey.new)
    @journey = journey
    @current_trip = nil
  end

  def start(entry_station)
    @journey.start(entry_station)
  end

  def store_journey
    @current_trip = @journey.journey_progress
  end
end
