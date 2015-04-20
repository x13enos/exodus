class StaticController < ApplicationController
  layout 'game'
  def home
    @game_id = Game.create.id
  end
end
