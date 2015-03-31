class StaticController < ApplicationController
  def home
    @game_id = Game.create.id
  end
end
