require 'spec_helper'

describe Exodus::Algorithms::StartingGemsPosition do
  let(:player_1) { create(:user) }
  let(:player_2) { create(:user) }
  let(:game) do
    create(:game,
           :active_player_token => player_1.token,
           :inactive_player_token => player_2.token,
           :players_data => {
                              player_1.token => {
                                :hp => 1,
                                :max_alchemy => player_1.alchemy,
                                :max_green_mana => player_1.green_mana,
                                :max_gear => player_1.gear,
                                :max_blue_mana => player_1.blue_mana,
                                :max_piston => player_1.piston,
                                :alchemy => 0,
                                :gear => 0,
                                :blue_mana => 0,
                                :green_mana => 0,
                                :piston => 0,
                                :expirience => 0
                              },
                              player_2.token => {
                                :hp => 2,
                                :max_alchemy => player_2.alchemy,
                                :max_green_mana => player_2.green_mana,
                                :max_gear => player_2.gear,
                                :max_blue_mana => player_2.blue_mana,
                                :max_piston => player_2.piston,
                                :alchemy => 0,
                                :gear => 0,
                                :blue_mana => 0,
                                :green_mana => 0,
                                :piston => 0,
                                :expirience => 0
                              }
                            }
          )
  end
  let(:board) { create(:board, :gems_position => { '2' => '5', '3' => '7' }) }
  let(:game_params) { { :game_id => game.id, :ids => ['2', '3'] } }
  let(:lib) { Exodus::Actions::MoveGem.new(game_params) }

  before do
    Game.delete_all
    allow(game).to receive(:players) { [player_1, player_2] }
    allow_any_instance_of(Game).to receive(:board) { board }
    allow_any_instance_of(Exodus::Callbacks::MoveGem).to receive(:perform) { true }
  end

  describe "#initialize" do

    it "should add gems position to instance variable" do
      expect(lib.gems_position).to eq(board.gems_position)
    end

    it "should add game to instance variable" do
      expect(lib.game).to eq(game)
    end

    it "should create gems_indexes instance variable" do
      expect(lib.gems_indexes).to eq(game_params[:ids])
    end
  end

  describe "#perform" do
    let(:service_object) { double(:perform => true) }

    context "when system can delete gems" do
      before do
        allow(service_object).to receive(:delete_able?) { true }
      end

      it "should create service object for calculate destroying gems" do
        expect(Exodus::Algorithms::DeleteCombinations).to receive(:new)
          .with(game, { '2' => '7', '3' => '5' }) { service_object }
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
        expect(lib.perform).to eq({:status=>"success", :result=>"ok"})
      end

      it "should change active player" do
        allow(lib).to receive(:game) { game }
        expect(game).to receive(:change_active_player)
        lib.perform
      end

      context "when opponent died" do
        let(:win_players_data) do
          {
            player_1.token => {
              :hp => -1,
              :max_alchemy => player_1.alchemy,
              :max_green_mana => player_1.green_mana,
              :max_gear => player_1.gear,
              :max_blue_mana => player_1.blue_mana,
              :max_piston => player_1.piston,
              :alchemy => 0,
              :gear => 0,
              :blue_mana => 0,
              :green_mana => 0,
              :piston => 0,
              :expirience => 0
            },
            player_2.token => {
              :hp => -2,
              :max_alchemy => player_2.alchemy,
              :max_green_mana => player_2.green_mana,
              :max_gear => player_2.gear,
              :max_blue_mana => player_2.blue_mana,
              :max_piston => player_2.piston,
              :alchemy => 0,
              :gear => 0,
              :blue_mana => 0,
              :green_mana => 0,
              :piston => 0,
              :expirience => 0
            }
          }
        end

        before do
          allow(lib.game).to receive(:players_data) { win_players_data }
        end

        it "should close game" do
          expect(lib.game).to receive(:close)
          lib.perform
        end

        it "should return status end" do
          expect(lib.perform[:status]).to eq('end')
        end

        it "should return sub_status win" do
          expect(lib.perform[:sub_status]).to eq('win')
        end
      end

      context "start broadcast data to second player" do
        let(:service_object) { double(:perform => true) }
        before do
          allow(Exodus::Algorithms::DeleteCombinations).to receive(:new) { service_object }
          allow(service_object).to receive(:perform) { '11' }
          allow(lib).to receive(:game) { game }
          allow(game).to receive(:active_player_token) {'344'}
        end

        it "should build broadcast service" do
          expect(Exodus::Callbacks::MoveGem).to receive(:new)
            .with(['2', '3'], { :status => 'success', :result => '11' }, '344') { double(:perform => true)  }
          lib.perform
        end

        it "should start broadcast service" do
          allow(Exodus::Callbacks::MoveGem).to receive(:new) { service_object }
          expect(service_object).to receive(:perform)
          lib.perform
        end
      end
    end


    context "when system can't delete gems" do
      before do
        allow(Exodus::Algorithms::DeleteCombinations).to receive(:new) { service_object }
        allow(service_object).to receive(:delete_able?) { false }
      end

      it "should return error status" do
        expect(lib.perform).to eq({ :status=> "error", :gems_indexes => ['2', '3'] })
      end
    end
  end

end
