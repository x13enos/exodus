require 'spec_helper'

describe Exodus::Game::CreateForTwoPlayers do
  let(:player_1) { create(:user) }
  let(:player_2) { create(:user) }
  let(:service) { Exodus::Game::CreateForTwoPlayers.new(player_1.token, player_2.token) }

  before do
    User.delete_all
  end

  describe "#initialize" do
    it "should assign first_player" do
      expect(service.first_player).to eq(player_1)
    end

    it "should assign second_player" do
      expect(service.second_player).to eq(player_2)
    end
  end

  describe "#perform" do
    before do
      Game.delete_all
      allow(Exodus::BroadcastDataToUser).to receive(:new) { double(:perform => true) }
    end

    it "should create new game" do
      service.perform
      expect(Game.count).to eq(1)
    end

    it "should add players to new game" do
      service.perform
      expect(Game.last.players).to eq([player_1, player_2])
    end

    context "need calculate starting gem positions" do
      let(:starting_gem_position_service) { double(:perform => true) }

      it "should build starting gem positions service" do
        expect(Exodus::Algorithms::StartingGemsPosition).to receive(:new) { starting_gem_position_service }
        service.perform
      end

      it "should execute starting gem positions service" do
        allow(Exodus::Algorithms::StartingGemsPosition).to receive(:new) { starting_gem_position_service }
        expect(starting_gem_position_service).to receive(:perform)
        service.perform
      end
    end

    context "need send callback to second user" do
      let(:broadband_service) { double(:perform => true) }

      it "should build broadband service" do
        expect(Exodus::BroadcastDataToUser)
           .to receive(:new).with({ :channel => "/#{player_2.token}/game/new" }) { broadband_service }
        service.perform
      end

      it "should execute broadband service" do
        allow(Exodus::BroadcastDataToUser).to receive(:new) { broadband_service }
        expect(broadband_service).to receive(:perform)
        service.perform
      end
    end
  end
end
