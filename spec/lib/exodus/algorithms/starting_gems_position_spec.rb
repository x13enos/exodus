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

    it "should return false if gems not have ability to deleting" do
      lib.perform
      board = Board.last
      delete_gems_lib = Exodus::Algorithms::DeleteCombinations.new(game, board.gems_position)
      expect(delete_gems_lib.delete_able?).to be_falsey
    end

    it "should create board" do
      Board.delete_all
      lib.perform
      expect(Board.count).to eq(1)
    end

    it "should return gems" do
      expect(lib.perform).to eq(lib.gems)
    end

    it "should return 64 length" do
      lib.perform
      expect(lib.gems.count).to eq(64)
    end
  end

end
