require 'spec_helper'

describe Exodus::Algorithms::DeleteCombinations do

  describe "#initialize" do
    let(:game) { create(:game) }
    let(:board) { create(:board, :game => game) }
    let(:lib) { Exodus::Algorithms::DeleteCombinations.new(game, board.gems_position) }

    before do
      Game.delete_all
      Board.delete_all
      [game, board]
    end

    it "should added gam to instance variable"  do
      expect(lib.game).to eq(game)
    end

    it "should added gems_position to instance variable" do
      expect(lib.gems_position.keys.first).to eq(board.gems_position.keys.first.to_i)
    end

    it "should added board to instance variable"  do
      expect(lib.board).to eq(board)
    end

    it "should added new_positions to instance variable"  do
      expect(lib.new_positions).to eq({})
    end
  end

  describe "#delete_able?" do
    let(:player_1) { create(:user) }
    let(:player_2) { create(:user) }
    let(:game) do create(:game,
                         :active_player_token => player_1.token,
                         :inactive_player_token => player_2.token)
    end
    let(:board) { create(:board, :game => game) }
    let(:lib) { Exodus::Algorithms::DeleteCombinations.new(game, board.gems_position) }

    before do
      Game.delete_all
      Board.delete_all
      [game, board, lib]
    end

    it "should return true if lib found combinations for deliting"  do
      lib.gems_position[0] = 1
      lib.gems_position[1] = 1
      lib.gems_position[2] = 1
      expect(lib.delete_able?).to be_truthy
    end

    it "should return false if lib dont found combinations for deliting"  do
      expect(lib.delete_able?).to be_falsey
    end
  end

  describe "#perform" do
    let(:player_1) { create(:user) }
    let(:player_2) { create(:user) }
    let(:game) do
      create(:game,
             :active_player_token => player_1.token,
             :inactive_player_token => player_2.token,
             :players_data => {
                player_1.token => {
                :hp => 1,
                :max_red_mana => player_1.red_mana,
                :max_green_mana => player_1.green_mana,
                :max_yellow_mana => player_1.yellow_mana,
                :max_blue_mana => player_1.blue_mana,
                :red_mana => 0,
                :yellow_mana => 0,
                :blue_mana => 0,
                :green_mana => 0,
                :expirience => 0,
                :money => 0
              },
                player_2.token => {
                :hp => 2,
                :max_red_mana => player_2.red_mana,
                :max_green_mana => player_2.green_mana,
                :max_yellow_mana => player_2.yellow_mana,
                :max_blue_mana => player_2.blue_mana,
                :red_mana => 0,
                :yellow_mana => 0,
                :blue_mana => 0,
                :green_mana => 0,
                :expirience => 0,
                :money => 0
              }
            }
      )
    end
    let(:board) { create(:board, :game => game) }
    let(:lib) { Exodus::Algorithms::DeleteCombinations.new(game, board.gems_position) }

    before do
      Game.delete_all
      Board.delete_all
      [game, board]
    end

    context "when gems don't have combinations for deleting" do
      it "should return data about deleting gems and new gems" do
        expect(lib.perform).to eq([])
      end
    end

    context "when gems have combinations for deleting" do
      before do
        lib.gems_position[0] = 1
        lib.gems_position[1] = 1
        lib.gems_position[2] = 1
      end

      it "should return data about deleting gems and new gems" do
        allow(lib).to receive(:random_gem).and_return(5, 6, 4)
        expect(lib.perform).to eq([{
          :delete_gems => [0,1,2],
          :new_gems_position => {
            :move_gems => [],
            :new_gems => [{:type => 5, :index => 2, :position => 1},
                          {:type => 6, :index => 1, :position => 1},
                          {:type => 4, :index => 0, :position => 1}]
          }
        }])
      end

      it "should update  players data" do
        allow(lib).to receive(:random_gem).and_return(5, 6, 4)
        lib.perform
        expect(game.reload.players_data[player_2.token]['green_mana']).to eq(3)
      end
    end
  end
end
