class Exodus::Algorithms::DeleteGems
  attr_accessor :game, :gems_position, :user_params, :indexes

  def initialize(indexes, game, gems_position)
    @indexes = indexes
    @game = game
    @user_params = game.players_data
    @gems_position = gems_position
  end

  def perform
    indexes.each do |i|
      write_changes_to_user_params(i) if gems_position[i].present?
      gems_position[i] = nil
    end
    { :gems_position => gems_position, :user_params => user_params }
  end

  private

  def write_changes_to_user_params(i)
    if Board::GEMS_TYPE[gems_position[i]] == Board::DAMAGE_GEM
      update_hp
    else
      update_element(Board::GEMS_TYPE[gems_position[i]])
    end
  end

  def update_hp
    user_params[game.inactive_player_token][:hp] -= 1
  end

  def update_element(element_type)
    if Board::MANA_GEMS.values.include?(element_type)
      (user_params[game.active_player_token][element_type] += 1) if user_not_reached_limit_by_this_mana(element_type)
    else
      user_params[game.active_player_token][element_type] += 1
    end
  end

  def user_not_reached_limit_by_this_mana(mana_type)
    user_params[game.active_player_token][('max_' + mana_type.to_s).to_sym] > user_params[game.active_player_token][mana_type]
  end
end
