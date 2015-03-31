require 'spec_helper'

describe Exodus::Algorithms::StartingGemsPosition do

  describe "#initialize" do
    let(:game) { create(:game) }
    let(:lib) { Exodus::Algorithms::StartingGemsPosition.new(game.id) }

    it "should add game id to instance variable" do
      expect(lib.game_id).to eq(game.id)
    end

    it "should create gems_hash instance variable" do
      expect(lib.gems_hash).to eq({})
    end
  end

  describe "#perform" do
    let(:game) { create(:game) }
    let(:lib) { Exodus::Algorithms::StartingGemsPosition.new(game.id) }
  end

end
