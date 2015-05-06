class GameController < ApplicationController
  layout 'game'

  def index
    @game = current_user.current_active_game
  end

  def new
    Exodus::Game::CreateForTwoPlayers.new(current_user.token, params[:token]).perform
    redirect_to game_index_path
  end

end
