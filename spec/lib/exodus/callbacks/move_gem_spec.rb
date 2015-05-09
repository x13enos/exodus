require 'spec_helper'

describe Exodus::Algorithms::StartingGemsPosition do
  let(:gems_index) { [1,2]  }
  let(:delete_data) { '11' }
  let(:user_token) { '000' }
  let(:lib) do
    Exodus::Callbacks::MoveGem.new(gems_index, delete_data, user_token)
  end

  describe "#initialize" do

    it "should add broadcast data to instance variable" do
      expect(lib.broadcast_data).to eq({ :gems_index => [1,2], :result => '11' })
    end

    it "should add second player token to instance variable" do
      expect(lib.second_player_token).to eq('000')
    end
  end

  describe "#perform" do
    let(:broadcast_service) { double(:perform => true) }

    it "should build broadcast service" do
      expect(Exodus::BroadcastDataToUser).to receive(:new)
        .with({ :channel => "/000/game/move_two_gems",
                :data => lib.broadcast_data }) { broadcast_service }
      lib.perform
    end

    it "should start broadcast service" do
      allow(Exodus::BroadcastDataToUser).to receive(:new) { broadcast_service }
      expect(broadcast_service).to receive(:perform)
      lib.perform
    end
  end
end

    # Exodus::BroadcastDataToUser.new({
    #   :channel => "/#{second_player_token}/game/move_two_gems",
    #   :data => broadcast_data
    # }).perform
