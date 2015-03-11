
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
    sequence=[]
  30.times {sequence << 5}#60 better
  7.times {[3,1,9,7].each{|num|sequence << num }}
  [2,4,6,8].each{|num|sequence << num }
  sequence = sequence.shuffle.uniq
    # 4 tactical changes of plan
    sequence = [ 5, 9, 3, 7, 1, 2, 4, 6, 8] if board.get_cell(6).mark == @other_mark || board.get_cell(8).mark == @other_mark
    sequence = [ 5, 9, 7, 3, 1, 2, 4, 6, 8] if board.get_cell(9).mark == @other_mark && board.get_cell(4).mark == @other_mark
    sequence = [ 5, 7, 9, 3, 1, 2, 4, 6, 8] if board.get_cell(1).mark == @other_mark && board.get_cell(8).mark == @other_mark
    sequence = [ 5, 2, 7, 9, 3, 1, 4, 6, 8] if (board.get_cell(1).mark == @other_mark && board.get_cell(9).mark == @other_mark) || (board.get_cell(3).mark == @other_mark && board.get_cell(7).mark == @other_mark)
    choice = 3 if board.turn_count == 0
    choice = 7 if board.turn_count == 2 && board.get_cell(5).mark == @other_mark

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