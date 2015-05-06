require 'spec_helper'
describe Exodus::Game::CurrentGemsPosition do
  let(:gems_position) { {'0' => 2, '1' => 4 } }
  let(:service) { Exodus::Game::CurrentGemsPosition.new(gems_position) }

  before do
    User.delete_all
  end

  describe "#initialize" do
    it "should assign gems_position" do
      expect(service.gems_position).to eq(gems_position)
    end

    it "should assign offset_array" do
      expect(service.offset_array).to eq((1..8).to_a.reverse)
    end
  end

  describe "#perform" do
    it "should return new hash with right data" do
      expect(service.perform)
        .to eq([{ :type => 2, :index => 0, :position => 8 }, { :type => 4, :index => 1, :position => 8 }])
    end
  end
end
