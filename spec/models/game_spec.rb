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
      end

      it "should change ative player token by game" do
        game.players << [user_1, user_2]
        game.update(:active_player_token => user_1.token)
        game.change_active_player
        expect(game.active_player_token).to eq(user_2.token)
      end
    end
  end
end
