
#-------------------
# PLAYER
#-------------------

class Player
  attr_reader :x_or_o, :name
  def initialize(settings_hsh)
    @x_or_o = settings_hsh[:x_or_o]
    @name = settings_hsh[:name]
  end
end

#-------------------
# Computer Player
#-------------------

class Computer < Player
  def initialize(settings_hsh)
    super(settings_hsh)
    @other_mark = settings_hsh.fetch(:other_mark, 'O')
  end

  def relevant_lines(cell, winning_lines)
    winning_lines.select{|line| line.include?(cell)}
  end

  def choose_move(board, winning_lines)
    choice = nil
    sequence = [ 5, 1, 3, 7, 9, 2, 4, 6, 8]
    sequence = [ 5, 9, 3, 7, 1, 2, 4, 6, 8] if board.get_cell(6).mark == @other_mark || board.get_cell(8).mark == @other_mark
    # This part checks for any winning moves
    sequence.each do |position|
        cell = board.get_cell(position)
        if cell.to_s == ' ' && relevant_lines(cell, winning_lines).any?{ |line| line.count{ |mark| mark.to_s == @x_or_o} == 2}
          choice = position
          break
        end
      end
    #makes sure they're not about to win!
    unless choice
      sequence.each do |position|
        cell = board.get_cell(position)
        if cell.to_s == ' ' && relevant_lines(cell, winning_lines).any?{ |line| line.count{ |mark| mark.to_s == @other_mark} == 2}
          choice = position
          break
        end
      end
    end
    # checks for any line with one of own mark and two blanks
    unless choice
        sequence.each do |position|
        cell = board.get_cell(position)
        if cell.to_s == ' ' && relevant_lines(cell, winning_lines).any?{ |line| line.any?{ |mark| mark.to_s == @x_or_o} && line.count{ |mark| mark.to_s == ' '} == 2}
          choice = position
          break
        end
      end
    end
    #none of above follows this simple routine
    unless choice
      sequence.each do |position|
        if board.get_cell(position).mark ==' '
          choice = position
          break
        end
      end
    end
    choice
  end
end