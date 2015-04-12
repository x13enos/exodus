class Exodus::Algorithms::StartingGemsPosition
  attr_accessor :gems, :game_id, :offset_array, :gems_hash
  def initialize(game_id)
    @game_id = game_id
    @gems = []
    @gems_hash = {}
    @offset_array = (1..8).to_a.reverse
  end

  def perform
    add_gems_to_hash
    create_board
    return gems
  end

  private

  def create_board
    Game.find(game_id).create_board(:gems_position => gems_hash)
  end

  def add_gems_to_hash
    (0..63).to_a.each do |index|
      gems << add_gem(index)
    end
  end

  def add_gem(index)
    gem_type = find_right_gem(index)
    gems_hash[index] = gem_type
    { :type => gem_type, :index => index, :position => gem_offset(index) }
  end

  def find_right_gem(index)
    first_array = available_gems_in_horizontal(index)
    second_array = available_gems_in_vertical(index)
    (Game::GEMS_NUMBER - (first_array + second_array)).sample
  end

  def gem_offset(index)
    offset_array[(index / 8)]
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
