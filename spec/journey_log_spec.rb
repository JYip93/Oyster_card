require "journey_log"
require "journey"

describe JourneyLog do
  let(:journey_double) { double :journey }
  let(:journey_class_double) { double :journey_class, new: journey_double }
  let(:station_double) {double :station_double}

  it "expects journeylog to be initialised with a journey class" do
    journ = journey_class_double.new
    journeylog = JourneyLog.new(journ)
    expect(journeylog.journey).to eq(journey_double)
  end

  describe "#start" do
    it "responds to start" do
      expect(subject).to respond_to(:start).with(1).argument
    end
  end

 # describe "#finish" do
   # it "finish a journey when exit station is given" do
      #journeylog = JourneyLog.new(journey_double)
      #expect(journeylog.finish(station_double).to 
    #end 
  #end


end
