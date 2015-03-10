#-------------------
# CELL
#-------------------

class Cell
  attr_accessor :mark

  def initialize(mark = " ")
    @mark = mark
  end
  def to_s
    @mark
  end #### get rid
end


#-------------------
# BOARD
#-------------------
class Board
  attr_accessor :grid
  attr_reader :turn_count

  def initialize(save = {})
    @grid = save.fetch(:grid, default_grid)
    @turn_count = 0
  end

  def default_grid
    Array.new(3) { Array.new(3) {Cell.new}}
  end

  def get_cell(position)
    x_val=position%3-1
    y_val=(position-1)/3
    @grid[y_val][x_val]
  end

  def mark_cell(position, x_or_o)
    unless get_cell(position).mark == ' '
      puts "Oops. That square's taken, try another one!"
      return nil
    end
    @turn_count += 1
    get_cell(position).mark = x_or_o
  end

  def winning_lines
    lines = @grid.clone
    @grid.transpose.each{|row| lines << row}

    lines << @grid.each_with_index.map{|row, index| row[index]}
    lines << @grid.each_with_index.map{|row, index| row[2 - index]}
  end

end