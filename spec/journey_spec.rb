require 'journey'

describe Journey do

  let(:entry_station){ double :station }
  let(:exit_station) { double :station }
  let(:day_out) {Journey.new}

  it 'initialises with a starting station' do
    day_out.start(entry_station)
    expect(day_out.trip).to have_value(entry_station)
  end

    it "check trip instance is a hash" do
      day_out.start(entry_station)
      expect(day_out.trip).to be_an_instance_of(Hash) 
    end

    it "check exit station is inside trip instance" do
      day_out.finish(exit_station)
      expect(day_out.trip).to have_value(exit_station)
       end

  
  describe '#fare' do

    it "will return minimum fare when both stations are present" do
      day_out.start(entry_station)
      day_out.finish(exit_station)
      expect(day_out.fare).to eq 1
    end

    it 'will return a penalty if a station is not present' do
      expect(day_out.fare).to eq 6
    end

    it "will return minimum fare when both stations are present" do
      day_out.start(entry_station)
      day_out.finish(exit_station)
      day_out.reset_hash
      expect(day_out.trip).to have_key("entry_station").and have_value(nil)
      expect(day_out.trip).to have_key("exit_station").and have_value(nil)
    end

  end
end
