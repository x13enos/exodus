class Exodus::Actions::MoveGem
  attr_accessor :gems_indexes, :gems_position, :game
  def initialize(params)
    @game = ::Game.find(params[:game_id])
    @gems_position = game.board.gems_position
    @gems_indexes = params[:ids]
  end

  def perform
    changed_indexes
    service = Exodus::Algorithms::DeleteCombinations.new(game.board, gems_position)
    if service.delete_able?
      result = { :status => 'success', :result => service.perform }
      change_active_player_and_send_callback(result)
      result
    else
      { :status => 'error', :gems_indexes => gems_indexes }
    end
  end

  private

  def change_active_player_and_send_callback(result)
    game.change_active_player
    Exodus::Callbacks::MoveGem.new(gems_indexes, result, game.active_player_token).perform
  end

  def changed_indexes
    values_for_changing = gems_indexes.map{|i| gems_position[i] }.reverse
    gems_indexes.each_with_index do |gem_index, index|
      gems_position[gem_index] = values_for_changing[index]
    end
  end

end
