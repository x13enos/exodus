class Exodus::Actions::MoveGem
  attr_accessor :gems_indexes, :gems_position, :board
  def initialize(params)
    @board = Game.find(params[:game_id]).board
    @gems_position = board.gems_position
    @gems_indexes = params[:ids]
  end

  def perform
    changed_indexes
    service = Exodus::Algorithms::DeleteCombinations.new(board, gems_position)
    if service.delete_able?
      service.perform
    else
      return 'error'
    end
  end

  private

  def changed_indexes
    values_for_changing = gems_indexes.map{|i| gems_position[i] }.reverse
    gems_indexes.each_with_index do |gem_index, index|
      gems_position[gem_index] = values_for_changing[index]
    end
  end

end
