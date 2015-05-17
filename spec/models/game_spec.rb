require 'spec_helper'

describe Game do
  context "Relations" do
    it { should have_and_belong_to_many(:players) }
    it { should have_one(:board) }
  end

  context "instance methods" do
    describe "#change_active_player"  do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }
      let(:game) { create(:game) }

      before do
        User.delete_all
        Game.delete_all
        game.players << [user_1, user_2]
      end

      it "should change ative player token by game" do
        game.update(:active_player_token => user_1.token)
        game.update(:inactive_player_token => user_2.token)
        game.change_active_player
        expect(game.active_player_token).to eq(user_2.token)
      end

      it "should change inative player token by game" do
        game.update(:active_player_token => user_1.token)
        game.update(:inactive_player_token => user_2.token)
        game.change_active_player
        expect(game.inactive_player_token).to eq(user_1.token)
      end
    end

    describe "#opponent" do
      let(:user_1) { build(:user) }
      let(:user_2) { build(:user) }
      let(:game) { build(:game) }

      it "should return opponent for current user" do
        game.players << [user_1, user_2]
        expect(game.opponent(user_1)).to eq(user_2)
      end
    end

    describe "close" do
      let(:game) { build(:game, :status => Game::ACTIVE_STATUS) }

      it "should udate game status on close" do
        game.close
        expect(game.status).to eq(Game::CLOSE_STATUS)
      end
    end
  end
end
