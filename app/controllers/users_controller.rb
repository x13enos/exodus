class UsersController < ApplicationController
  before_action :get_user, :except => [:edit, :update]
  before_action :get_user_by_id, :only => [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path, :notice => "User data was succesfully updated"
    else
      render :edit
    end
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

  def get_user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :avatar, :avatar_cache)
  end
end
