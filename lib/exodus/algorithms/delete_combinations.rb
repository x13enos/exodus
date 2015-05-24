class Exodus::Algorithms::DeleteCombinations
  GEMS_TYPE = [:blue_mana, :green_mana, :red_mana, :yellow_mana, :hp, :expirience, :money]

  attr_accessor :gems_position, :game, :board, :new_positions
  def initialize(game, gems_position)
    @game = game
    @board = game.board
    @gems_position = gems_position.inject({}) { |memo, item| memo[Integer(item[0])] = item[1]; memo }
    @new_positions = {}
  end

  def delete_able?
    indexes_removes_gems.present?
  end

  def perform
    result = update_positions_handler
    update_board
    update_players_data
    return result
  end

  private

  def update_positions_handler
    result = []
    while(delete_able?) do
      delete_gems(indexes_removes_gems)
      result << step_result
    end

    result
  end

  def step_result
    { :delete_gems => indexes_removes_gems,
      :new_gems_position => add_new_gems }
  end

  def update_board
    board.update_attribute(:gems_position, gems_position)
  end

  def update_players_data
    game.save
  end

  def indexes_removes_gems
    combination_by_horizontal + combination_by_vertical
  end

  def delete_gems(indexes)
    user_params = game.players_data[game.inactive_player_token]
    indexes.each do |i|
      write_changes_to_user_params(user_params, i) if gems_position[i].present?
      gems_position[i] = nil
    end
  end

  def write_changes_to_user_params(user_params, i)
      if gems_position[i] == Board::DAMAGE_GEM
        user_params[:hp] -= 1
      else
        user_params[GEMS_TYPE[gems_position[i]]] += 1
      end
  end

  def add_new_gems
    h = { :move_gems => [], :new_gems => [] }
    (0..63).to_a.reverse.each do |i|
      if gems_position[i].nil?
        c_i = i
        while (gems_position[i].nil? && c_i / 8 >= 0) do
          c_i -= 8
          if gems_position[c_i].present?
            h[:move_gems] << move_gem(i, c_i)
          end
        end
        if gems_position[i].nil?
          h[:new_gems] << create_new_gem(i)
        end
      end
    end
    return h
  end

  def update_gem_position(index, new_gem)
    gems_position[index] = new_gem
    return new_gem
  end

  def move_gem(current_gem_index, move_gem_index)
    t = { :type => gems_position[move_gem_index],
          :index => current_gem_index,
          :old_index => move_gem_index  }
    gems_position[move_gem_index] = nil
    update_gem_position(t[:index], t[:type])
    t
  end

  def create_new_gem(index)
    new_gem = random_gem
    update_new_position_variables(index)
    update_gem_position(index, new_gem)
    { :type => new_gem,
      :index => index,
      :position => new_positions[index % 8] }
  end

  def random_gem
    (0..6).to_a.sample
  end

  def update_new_position_variables(index)
    column = index.to_i % 8
    if new_positions[column]
      new_positions[column] += 1
    else
      new_positions[column] = 1
    end
  end

  def combination_by_horizontal
    indexes = []
    t = 0
    Board::MATRIX.each do |row|
      row.each_with_index do |hash_index, row_index|
        if row_index != (row.size - 1) && gems_position[hash_index] == gems_position[(hash_index + 1)]
          t += 1
        else
          if t >= 2
            ((hash_index - t)..hash_index).to_a.each { |i| indexes << i }
          end
          t = 0
        end
      end
    end
    indexes
  end

  def combination_by_vertical
    indexes = []
    t = 0
    Board::MATRIX.transpose.each do |column|
      column.each_with_index do |hash_index, column_index|
        if column_index != (column.size - 1) && gems_position[hash_index] == gems_position[(hash_index + 8)]
          t += 1
        else
          if t >= 2
            column[(column_index - t..column_index)].each { |i| indexes << i }
          end
          t = 0
        end
      end
    end
    indexes
  end
end
