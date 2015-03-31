class Exodus::Algorithms::DeleteCombinations
  attr_accessor :gems_position, :board
  def initialize(board, gems_position)
    @board = board
    @gems_position = gems_position
  end

  def delete_able?
    indexes_removes_gems.present?
  end

  def perform
    result = []
    while(delete_able?) do
      delete_gems(indexes_removes_gems)
      result << { :delete_gems => indexes_removes_gems, :new_gems_position => add_new_gems }
    end
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
    h = {}
    (0..63).to_a.reverse.each do |i|
      if gems_position[i.to_s].nil?
        c_i = i
        while (gems_position[i.to_s].nil? && c_i / 8 >= 0) do
          c_i -= 8
          if gems_position[c_i.to_s].present?
            h[i.to_s] = update_gem_position(i.to_s, gems_position[c_i.to_s])
            gems_position[c_i.to_s] = nil
          end
        end
        h[i.to_s] = update_gem_position(i.to_s, (0..6).to_a.sample) if gems_position[i.to_s].nil?
      end
    end
    return h
  end

  def update_gem_position(index, new_gem)
    gems_position[index] = new_gem
    return new_gem
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
