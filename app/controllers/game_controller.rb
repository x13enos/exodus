class GameController < ApplicationController
  def starting_gems_position
    @start_gems_position = Exodus::Algorithms::StartingGemsPosition.new(params[:game_id]).perform
    render :json => @start_gems_position
  end
end
