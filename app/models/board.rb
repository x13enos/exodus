class Board
  include Mongoid::Document

  MATRIX = (0..63).to_a.in_groups_of(8)
  GEMS_TYPE = { 0 => :blue_mana, 1 => :green_mana, 2 => :alchemy,
                3 => :gear, 4 => :piston,  5 => :hp, 6 => :expirience }
  MANA_GEMS = { 0 => :blue_mana, 1 => :green_mana, 2 => :alchemy, 3 => :gear, 4 => :piston }
  DAMAGE_GEM = :hp

  field :gems_position, :type => Hash

  belongs_to :game

  def current_gems_position
    Exodus::Game::CurrentGemsPosition.new(gems_position).perform
  end
end
