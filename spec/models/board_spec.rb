require 'spec_helper'

describe Board do
  context "Relations" do
    it { should belong_to(:game) }
  end

  context "Instance methods" do
    describe "#current_gems_position" do
      let(:board) { create(:board, :gems_position => { '0' => 2, '1' => 1 }) }
      let(:service) { double(:perform => true) }

      it "should build service for getting gems position" do
        expect(Exodus::Game::CurrentGemsPosition).to receive(:new)
          .with(board.gems_position) { service }
        board.current_gems_position
      end

      it "should execute service for getting gems position" do
        allow(Exodus::Game::CurrentGemsPosition).to receive(:new) { service }
        expect(service).to receive(:perform)
        board.current_gems_position
      end
    end
  end
end
