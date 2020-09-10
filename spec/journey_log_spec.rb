require "journey_log"
require "journey"

describe JourneyLog do
  let(:journey_double) { double :journey }
  let(:journey_class_double) { double :journey_class, new: journey_double }

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
end
