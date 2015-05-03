require 'spec_helper'

describe User do
  context "Relations" do
    it { should have_and_belong_to_many(:friends) }
    it { should have_many(:notifications) }
  end

  context "Validations" do
    it { should validate_presence_of(:name) }
  end

  context "Instance methods" do
    describe "#add_friend" do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }

      before do
        User.delete_all
      end

      it "should add friend if user not current_user and user do not already friend" do
        user_1.add_friend(user_2.token)
        expect(user_1.friends).to include(user_2)
      end

      it "should not add friend if user it's current_user" do
        user_1.add_friend(user_1.token)
        expect(user_1.friends.count).to eq(0)
      end

      it "should not add friend if user already friend for current_user" do
        allow(user_1).to receive(:friends) { [user_2] }
        user_1.add_friend(user_2.token)
        expect(user_1.friends.count).to eq(1)
      end
    end

    describe "#remove_friend" do
      let(:user_1) { create(:user) }
      let(:user_2) { create(:user) }

      before do
        User.delete_all
      end

      it "should delete user from current_user friends" do
        user_1.add_friend(user_2.token)
        user_1.remove_friend(user_2.token)
        expect(user_1.friends.count).to eq(0)
      end
    end

    describe "#create_game_invite" do
      let(:recipient) { create(:user) }
      let(:sender) { create(:user) }
      let(:notification) { build(:notification) }

      before do
        User.delete_all
        Notification.delete_all
      end

      it "should create notification with right subspicies" do
        allow_any_instance_of(Notification).to receive(:broadcast)
        recipient.create_game_invite(sender.id)
        expect(recipient.notifications.last.subspecies).to eq(Notification::INVITE_SUBSPECIES)
      end

      it "should create notification with right sender_id" do
        allow_any_instance_of(Notification).to receive(:broadcast)
        recipient.create_game_invite(sender.id)
        expect(recipient.notifications.last.sender).to eq(sender)
      end

      it "should create notification with right sender_id" do
        allow(recipient).to receive(:notifications) { double(:create => notification) }
        expect(notification).to receive(:broadcast)
        recipient.create_game_invite(sender.id)
      end
    end
  end
end
