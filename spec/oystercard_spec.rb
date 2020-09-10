require "oystercard"

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:oystercard10) { Oystercard.new(10) }
  let(:oystercard1) { Oystercard.new(1) }
  let(:oystercard0) { Oystercard.new(0) }

  describe "#balance" do
    it "has a default balance of 0" do
      expect(subject.balance).to eq 0
    end
  end

  describe "#history" do
    it "checks that the card has an empty list of journeys by default" do
      expect(oystercard1.history).to be_empty
    end
  end

  it "touching in and out creates one journey" do
    oystercard10.touch_in(entry_station)
    oystercard10.touch_out(exit_station)
    expect(oystercard10.history).not_to be_empty
  end

  describe "#top_up" do
    it "adds an amount to a card balance" do
      amount = 30
      expect(oystercard0.top_up(amount)).to eq 30
    end

    it "raises an error if card topped up more than GBP90" do
      expect { oystercard0.top_up(Oystercard::LIMIT + 1) }.to raise_error "Card reached the GBP#{Oystercard::LIMIT} limit"
    end
  end

  describe "#touch_in" do
    it "raises an error after touch in method when balance is less than 1" do
      expect { oystercard0.touch_in(entry_station) }.to raise_error "Minimum amount to travel is GBP1"
    end

    it "will reset entry station to nil" do
      oystercard1.touch_in(entry_station)
      oystercard1.touch_out(exit_station)
      expect { oystercard1.touch_in(entry_station) }.to raise_error "Minimum amount to travel is GBP1"
      expect(oystercard1.current_trip).to eq nil
    end
  end

  describe "#touch_out" do
    it "will deduct minimum fare from the balance" do
      oystercard1.touch_in(entry_station)
      expect { oystercard1.touch_out(exit_station) }.to change { oystercard1.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

    it "Entry and exit stations added to journey list" do
      oystercard10.touch_in("Kings Cross")
      oystercard10.touch_out("Liverpool Street")
      expect(oystercard10.history).to eq([{ "entry_station" => "Kings Cross", "exit_station" => "Liverpool Street" }])
    end
  end
end
