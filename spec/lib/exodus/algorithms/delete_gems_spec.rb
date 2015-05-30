require 'spec_helper'

describe Exodus::Algorithms::DeleteGems do
  let(:player_1) { create(:user) }
  let(:player_2) { create(:user) }

  describe "#initialize" do
    let(:indexes) { [2,3,4] }
    let(:user_params) do
      { :hp => 1,
        :max_red_mana => 10,
        :max_green_mana => 10,
        :max_yellow_mana => 10,
        :max_blue_mana => 10,
        :red_mana => 0,
        :yellow_mana => 0,
        :blue_mana => 0,
        :green_mana => 0,
        :expirience => 0,
        :money => 0 }
    end
    let(:board) { create(:board) }
    let(:game) do create(:game,
                         :active_player_token => player_1.token,
                         :inactive_player_token => player_2.token,
                         :players_data => {
                           player_1.token => user_params,
                           player_2.token => user_params
                         })
    end
    let(:lib) { Exodus::Algorithms::DeleteGems.new(indexes, game, board.gems_position ) }


    it "should added indexes to instance variable"  do
      expect(lib.indexes).to eq(indexes)
    end

    it "should added user_params to instance variable"  do
      expect(lib.user_params).to eq(game.players_data)
    end

    it "should added gems_position to instance variable"  do
      expect(lib.gems_position).to eq(board.gems_position)
    end
  end

  describe "#perform" do
    let(:indexes) { [2,3,4] }
    let(:user_params) do
      { :hp => 1,
        :max_red_mana => 10,
        :max_green_mana => 10,
        :max_yellow_mana => 10,
        :max_blue_mana => 10,
        :red_mana => 0,
        :yellow_mana => 0,
        :blue_mana => 0,
        :green_mana => 0,
        :expirience => 0,
        :money => 0 }
    end
    let(:game) do create(:game,
                         :active_player_token => player_1.token,
                         :inactive_player_token => player_2.token,
                         :players_data => {
                           player_1.token => user_params,
                           player_2.token => user_params
                         })
    end
    let(:board) { create(:board) }
    let(:lib) { Exodus::Algorithms::DeleteGems.new(indexes, game, board.gems_position ) }

    it "should return gems_position after gems deleting" do
      new_gems_position = board.gems_position
      new_gems_position[2] = nil
      new_gems_position[3] = nil
      new_gems_position[4] = nil
      expect(lib.perform[:gems_position]).to eq(new_gems_position)
    end

    it "should return updating user_params after gems deleting" do
      lib.gems_position[2] = 1
      lib.gems_position[3] = 1
      lib.gems_position[4] = 1
      expect(lib.perform[:user_params][player_1.token][:green_mana]).to eq(3)
    end

    it "should return updating player hp after gems deleting" do
      lib.gems_position[2] = Board::GEMS_TYPE.index(:hp)
      lib.gems_position[3] = Board::GEMS_TYPE.index(:hp)
      lib.gems_position[4] = Board::GEMS_TYPE.index(:hp)
      expect(lib.perform[:user_params][player_2.token][:hp]).to eq(-2)
    end

    it "should not return mana more than user can have" do
      user_params[:green_mana] = 9
      lib.gems_position[2] = 1
      lib.gems_position[3] = 1
      lib.gems_position[4] = 1
      expect(lib.perform[:user_params][player_1.token][:green_mana]).to eq(10)
    end
  end
end
