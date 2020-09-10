require_relative "journey"

class JourneyLog
  attr_reader :journey

  def initialize(journey = Journey)
    @journey = journey
  end

  def start(entry_station)
    @journey.start(entry_station)
  end
end
