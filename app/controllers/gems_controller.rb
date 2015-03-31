class GemsController < ApplicationController
  def move
    delete_data = Exodus::Actions::MoveGem.new(params).perform
    render :json => delete_data
  end
end
