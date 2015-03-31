class Exodus::Algorithms::StartingGemsPosition
  attr_accessor :gems_number, :gems_hash, :game_id
  def initialize(game_id)
    @game_id = game_id
    @gems_hash = {}
  end

  def perform
    add_gems_to_hash
    create_board
    return gems_hash
  end

  private

  def create_board
    Game.find(game_id).create_board(:gems_position => gems_hash)
  end

  def add_gems_to_hash
    (0..63).to_a.each do |index|
      gems_hash[index] = find_right_gem(index)
    end
  end

  def find_right_gem(index)
    first_array = available_gems_in_horizontal(index)
    second_array = available_gems_in_vertical(index)
    (Game::GEMS_NUMBER - (first_array + second_array)).sample
  end

  def available_gems_in_horizontal(index)
    if (index % 8 >= 2) && gems_hash[index - 1] == gems_hash[index - 2]
      [gems_hash[index - 1]]
    else
      []
    end
  end

  def available_gems_in_vertical(index)
    if (index / 8 >= 2) && gems_hash[index - 8] == gems_hash[index - 16]
      [gems_hash[index - 8]]
    else
      []
    end
  end
end
