class Board
  include Mongoid::Document

  MATRIX = (0..63).to_a.in_groups_of(8)
  DAMAGE_GEM = 4
  GEM_TYPE = ['blue', 'green', 'red', 'yellow', 'scull', 'star', 'coin']

  field :gems_position, :type => Hash

  belongs_to :game

  def current_gems_position
    Exodus::Game::CurrentGemsPosition.new(gems_position).perform
  end
end
