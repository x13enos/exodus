class Exodus::Algorithms::DeleteGems
  GEMS_TYPE = [:blue_mana, :green_mana, :red_mana, :yellow_mana, :hp, :expirience, :money]
  GEMS_TYPE_MANA = [:blue_mana, :green_mana, :red_mana, :yellow_mana]

  attr_accessor :gems_position, :user_params, :indexes

  def initialize(indexes, user_params, gems_position)
    @indexes = indexes
    @user_params = user_params
    @gems_position = gems_position
  end

  def perform
    indexes.each do |i|
      write_changes_to_user_params(user_params, i) if gems_position[i].present?
      gems_position[i] = nil
    end
    { :gems_position => gems_position, :user_params => user_params }
  end

  private

  def write_changes_to_user_params(user_params, i)
    if gems_position[i] == Board::DAMAGE_GEM
      update_hp
    else
      update_element(GEMS_TYPE[gems_position[i]])
    end
  end

  def update_hp
    user_params[:hp] -= 1
  end

  def update_element(element_type)
    if GEMS_TYPE_MANA.include?(element_type)
      (user_params[element_type] += 1) if user_not_reached_limit_by_this_mana(element_type)
    else
      user_params[element_type] += 1
    end
  end

  def user_not_reached_limit_by_this_mana(mana_type)
    user_params[('max_' + mana_type.to_s).to_sym] > user_params[mana_type]
  end
end
