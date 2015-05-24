class UsersController < ApplicationController
  before_action :get_user

  def show
  end

  def add_friend
    current_user.add_friend(@user.token)
    redirect_to root_path
  end

  def remove_friend
    current_user.remove_friend(@user.token)
    redirect_to root_path
  end

  def send_invite_to_game
    @user.create_game_invite(current_user.id)
    render :json => { :status => 'ok' }
  end


  private

  def get_user
    @user = User.find_by(:token => params[:id]) || User.find_by(:nickname => params[:id])
  end
end
