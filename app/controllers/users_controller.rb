class UsersController < ApplicationController
  before_action :get_user

  def show
  end

  def add_friend
    current_user.add_friend(params[:id])
    redirect_to root_path
  end

  def remove_friend
    current_user.remove_friend(params[:id])
    redirect_to root_path
  end

  private

  def get_user
    @user = User.find_by_token(params[:id])
  end
end
