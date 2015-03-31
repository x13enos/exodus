require 'spec_helper'

describe Exodus::Algorithms::StartingGemsPosition do
  let(:game) { create(:game) }
  let(:board) { create(:board, :gems_position => { '2' => '5', '3' => '7' }) }
  let(:game_params) { { :game_id => game.id, :ids => ['2', '3'] } }
  let(:lib) { Exodus::Actions::MoveGem.new(game_params) }

  before do
    allow_any_instance_of(Game).to receive(:board) { board }
  end

  describe "#initialize" do

    it "should add gems position to instance variable" do
      expect(lib.gems_position).to eq(board.gems_position)
    end

    it "should add board to instance variable" do
      expect(lib.board).to eq(board)
    end

    it "should create gems_indexes instance variable" do
      expect(lib.gems_indexes).to eq(game_params[:ids])
    end
  end

  describe "#perform" do
    let(:service_object) { double(:perform => true, :delete_able? => true) }

    it "should create service object for calculate destroying gems" do
      expect(Exodus::Algorithms::DeleteCombinations).to receive(:new)
        .with(board, { '2' => '7', '3' => '5' }) { service_object }
      lib.perform
    end

    it "should start service object for calculate destroying gems" do
      allow(Exodus::Algorithms::DeleteCombinations).to receive(:new) { service_object }
      expect(service_object).to receive(:perform)
      lib.perform
    end

    it "should return calculating destroying gems result" do
      allow(Exodus::Algorithms::DeleteCombinations).to receive(:new) { service_object }
      allow(service_object).to receive(:perform) { 'ok' }
      expect(lib.perform).to eq(:delete_gems => 'ok')
    end
  end

end
