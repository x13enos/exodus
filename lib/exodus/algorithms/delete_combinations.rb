class Exodus::Algorithms::DeleteCombinations
  attr_accessor :gems_position, :board, :new_positions
  def initialize(board, gems_position)
    @board = board
    @gems_position = gems_position
    @new_positions = {}
  end

  def delete_able?
    indexes_removes_gems.present?
  end

  def perform
    result = []
    while(delete_able?) do
      new_positions = {}
      delete_gems(indexes_removes_gems)
      result << { :delete_gems => indexes_removes_gems, :new_gems_position => add_new_gems }
    end
    Rails.logger.info result
    return result
  end

  private

  def indexes_removes_gems
    combination_by_horizontal + combination_by_vertical
  end

  def delete_gems(indexes)
    indexes.each { |i| gems_position[i.to_s] = nil }
  end

  def add_new_gems
    h = { :move_gems => [], :new_gems => [] }
    (0..63).to_a.reverse.each do |i|
      if gems_position[i.to_s].nil?
        c_i = i
        while (gems_position[i.to_s].nil? && c_i / 8 >= 0) do
          c_i -= 8
          if gems_position[c_i.to_s].present?
            h[:move_gems] << move_gem(i.to_s, c_i.to_s)
          end
        end
        if gems_position[i.to_s].nil?
          h[:new_gems] << create_new_gem(i.to_s)
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
    t = { :type => gems_position[move_gem_index.to_s],
          :index => current_gem_index,
          :old_index => move_gem_index  }
    gems_position[move_gem_index.to_s] = nil
    update_gem_position(t[:index], t[:type])
    t
  end

  def create_new_gem(index)
    random_gem = (0..6).to_a.sample
    update_new_position_variables(index)
    update_gem_position(index, random_gem)
    { :type => random_gem,
      :index => index,
      :position => new_positions[index.to_i % 8] }
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
        if row_index != (row.size - 1) && gems_position[hash_index.to_s] == gems_position[(hash_index + 1).to_s]
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
        if column_index != (column.size - 1) && gems_position[hash_index.to_s] == gems_position[(hash_index + 8).to_s]
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
