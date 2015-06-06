class Exodus::Algorithms::PossibleCombinations

  attr_accessor :g_p

  def initialize(gems_position)
    @g_p = gems_position.inject({}) { |memo, item| memo[Integer(item[0])] = item[1]; memo }
  end

  def perform
    have_combinations?
  end

  private

  def have_combinations?
    combinations_in_rows || combinations_in_columns
  end

  def combinations_in_rows
    status = false
    Board::MATRIX.each do |row|
      row.each do |i|
        if (g_p[i] == g_p[i - 1] && row.include?(i - 1) && check_row(i, 'by_sides')) ||
          (g_p[i] == g_p[i - 2] && row.include?(i - 2) && check_row(i, 'between'))
         status = true
         break
        end
      end
    end
    return status
  end

  def check_row(index, type)
    if type == 'between'
      have_combinations_between_in_a_row?(index)
    else
      have_combinations_by_sides_in_a_row?(index)
    end
  end

  def have_combinations_between_in_a_row?(index)
    top_between_row(index) || bottom_between_row(index)
  end

  def top_between_row(index)
    g_p[index - 9] == g_p[index]
  end

  def bottom_between_row(index)
    g_p[index + 7] == g_p[index]
  end

  def have_combinations_by_sides_in_a_row?(index)
    left_side_row(index) || right_side_row(index)
  end

  def left_side_row(i)
    if i % 8 > 2
      [g_p[i - 3], g_p[i - 10], g_p[i + 6]].include?(g_p[i])
    elsif i % 8 == 2
      [g_p[i - 10], g_p[i + 6]].include?(g_p[i])
    end
  end

  def right_side_row(i)
    if i % 8 < 6
      [g_p[i + 2], g_p[i - 7], g_p[i + 9]].include?(g_p[i])
    elsif i % 8 == 6
      [g_p[i - 7], g_p[i + 9]].include?(g_p[i])
    end
  end

  def combinations_in_columns
    status = false
    Board::MATRIX.transpose.each do |column|
      column.each do |i|
        if (g_p[i] == g_p[i - 8] && column.include?(i - 8) && check_column(i, 'by_sides')) ||
          (g_p[i] == g_p[i - 16] && column.include?(i - 16) && check_column(i, 'between'))
         status = true
         break
        end
      end
    end
    return status
  end

  def check_column(index, type)
    if type == 'between'
      have_combinations_between_in_a_column?(index)
    else
      have_combinations_by_sides_in_a_column?(index)
    end
  end

  def have_combinations_between_in_a_column?(index)
    left_between_row(index) || right_between_row(index)
  end

  def left_between_row(index)
    if index % 8 > 0
      g_p[index - 9] == g_p[index]
    end
  end

  def right_between_row(index)
    if index % 8 < 7
      g_p[index - 7] == g_p[index]
    end
  end

  def have_combinations_by_sides_in_a_column?(index)
    top_side_column(index) || bottom_side_column(index)
  end

  def top_side_column(i)
    array_values = [g_p[i - 24]]
    if i % 8 == 0
      array_values.push(g_p[i - 15])
    elsif i % 8 == 7
      array_values.push(g_p[i - 17])
    else
      array_values.push(g_p[i - 15], g_p[i - 17])
    end
    array_values.include?(g_p[i])
  end

  def bottom_side_column(i)
    array_values = [g_p[i + 8]]
    if i % 8 == 0
      array_values.push(g_p[i + 9])
    elsif i % 8 == 7
      array_values.push(g_p[i + 7])
    else
      array_values.push(g_p[i + 9], g_p[i + 7])
    end
    array_values.include?(g_p[i])
  end

end
