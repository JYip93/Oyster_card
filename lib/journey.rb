class Journey
  attr_reader :journey, :entry_station, :trip, :exit_station, :journey_progress

  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6

  def initialize
    @trip = { "entry_station" => nil, "exit_station" => nil }
  end

  def start(entry_station)
    @trip["entry_station"] = entry_station
  end

  def finish(exit_station)
    @trip["exit_station"] = exit_station
  end

  def journey_progress
    @trip
  end

  def reset_hash
    @trip = { "entry_station" => nil, "exit_station" => nil }
  end

  def fare
    if @trip["entry_station"] == nil || @trip["exit_station"] == nil
      PENALTY_CHARGE
    else
      MINIMUM_CHARGE
    end
  end
end
