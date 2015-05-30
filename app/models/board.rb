class Board
  include Mongoid::Document

  MATRIX = (0..63).to_a.in_groups_of(8)
  GEMS_TYPE = { 0 => :blue_mana, 1 => :green_mana, 2 => :red_mana,
                3 => :yellow_mana, 4 => :hp,  5 => :expirience, 6 => :money }
  MANA_GEMS = { 0 => :blue_mana, 1 => :green_mana, 2 => :red_mana, 3 => :yellow_mana }
  DAMAGE_GEM = :hp

  field :gems_position, :type => Hash

  belongs_to :game

  def current_gems_position
    Exodus::Game::CurrentGemsPosition.new(gems_position).perform
  end
end
