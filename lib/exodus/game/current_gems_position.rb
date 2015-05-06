class Exodus::Game::CurrentGemsPosition
  attr_accessor :gems_position, :offset_array

  def initialize(gems_position)
    @gems_position = gems_position
    @offset_array = (1..8).to_a.reverse
  end

  def perform
    build_hash_with_current_gems_position
  end

  private

  def build_hash_with_current_gems_position
    gems_position.each_with_object([]){ |(i, t), array| array << gem_params(i.to_i, t) }
  end

  def gem_params(index, gem_type)
    { :type => gem_type, :index => index, :position => gem_offset(index) }
  end

  def gem_offset(index)
    offset_array[(index / 8)]
  end
end
