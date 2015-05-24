require 'spec_helper'

describe UsersController do
  describe 'GET show' do
    let(:user) { create(:user) }

    it "returns http success" do
      get 'show', :id => user.token
      expect(response).to be_success
    end

    it "should assigns user" do
      allow(User).to receive(:find_by_token) { user }
      get 'show', :id => user.token
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT add_friend' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    before do
      allow(controller).to receive(:current_user) { user }
    end

    it "returns http success" do
      put 'add_friend', :id => user.token
      expect(response).to be_redirect
    end

    it "should assigns user if we use user token" do
      allow(User).to receive(:find_by_token) { user }
      put 'add_friend', :id => user.token
      expect(assigns(:user)).to eq(user)
    end

    it "should assigns user if we use user token" do
      allow(User).to receive(:find_by_nickname) { user }
      put 'add_friend', :id => user.nickname
      expect(assigns(:user)).to eq(user)
    end

    it "should call method add_friend for current_user" do
      allow(User).to receive(:find_by_token) { friend }
      allow(user).to receive(:add_friend).with(friend.token)
      put 'add_friend', :id => friend.token
    end
  end

  describe 'PUT remove_friend' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    before do
      allow(controller).to receive(:current_user) { user }
    end

    it "returns http success" do
      put 'remove_friend', :id => user.token
      expect(response).to be_redirect
    end

    it "should assigns user" do
      allow(User).to receive(:find_by_token) { user }
      put 'remove_friend', :id => user.token
      expect(assigns(:user)).to eq(user)
    end

    it "should call method remove_friend for current_user" do
      allow(User).to receive(:find_by_token) { friend }
      allow(user).to receive(:delete_friend).with(friend.token)
      put 'remove_friend', :id => friend.token
    end
  end

  describe 'POST send_invite_to_game' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    before do
      allow(controller).to receive(:current_user) { user }
      allow_any_instance_of(User).to receive(:create_game_invite)
    end

    it "returns http success" do
      post 'send_invite_to_game', :id => user.token
      expect(response.body).to eq({ :status => 'ok' }.to_json)
    end

    it "should assigns user" do
      allow(User).to receive(:find_by_token) { user }
      post 'send_invite_to_game', :id => user.token
      expect(assigns(:user)).to eq(user)
    end

    it "should call method add_friend for current_user" do
      allow(User).to receive(:find_by_token) { friend }
      allow(user).to receive(:create_game_invite).with(friend.token)
      post 'send_invite_to_game', :id => friend.token
    end
  end
end
