require 'spec_helper'

describe Exodus::Game::CreateForTwoPlayers do
  let(:player_1) { create(:user, :hp => 100) }
  let(:player_2) { create(:user, :hp => 101) }
  let(:service) { Exodus::Game::CreateForTwoPlayers.new(player_1.token, player_2.token) }
  let(:game) { create(:game) }

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

    it "should assign players" do
      expect(service.players).to eq([player_1, player_2])
    end
  end

  describe "#perform" do
    let(:players_data) do
      { player_1.token => { :hp => 100,
                            :money => 0,
                            :max_red_mana => player_1.red_mana,
                            :max_green_mana => player_1.green_mana,
                            :max_yellow_mana => player_1.yellow_mana,
                            :max_blue_mana => player_1.blue_mana,
                            :red_mana => 0,
                            :blue_mana => 0,
                            :green_mana => 0,
                            :yellow_mana => 0,
                            :money => 0,
                            :expirience => 0
                          },
        player_2.token => { :hp => 101,
                            :money => 0,
                            :max_red_mana => player_2.red_mana,
                            :max_green_mana => player_2.green_mana,
                            :max_yellow_mana => player_2.yellow_mana,
                            :max_blue_mana => player_2.blue_mana,
                            :red_mana => 0,
                            :blue_mana => 0,
                            :green_mana => 0,
                            :yellow_mana => 0,
                            :money => 0,
                            :expirience => 0
                          }
      }
    end
    let(:players_tokens) { [player_1.token, player_2.token] }

    before do
      Game.delete_all
      allow(Exodus::BroadcastDataToUser).to receive(:new) { double(:perform => true) }
    end

    it "should create new game with options" do
      allow(service.players).to receive(:map) { players_tokens }
      allow(players_tokens).to receive(:sample) { player_1.token }
      expect(Game).to receive(:create)
        .with({ :status => ::Game::ACTIVE_STATUS,
                :active_player_token => player_1.token,
                :inactive_player_token => player_2.token,
                :players_data => players_data }) { game }
      service.perform
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
