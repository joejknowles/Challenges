
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

  def mark_at(board, position)
    board.get_cell(position).mark
  end

  def choose_move(board, winning_lines)
    choice = nil
    sequence = [ 5, 1, 3, 7, 9, 2, 4, 6, 8]
    # 4 tactical changes of plan
    sequence = [ 5, 9, 3, 7, 1, 2, 4, 6, 8] if (mark_at(board, 6) == @other_mark || mark_at(board, 8) == @other_mark) && mark_at(board, 7) == @x_or_o
    sequence = [ 5, 9, 7, 3, 1, 2, 4, 6, 8] if mark_at(board, 9) == @other_mark && mark_at(board, 4) == @other_mark || (mark_at(board, 2) == @other_mark && mark_at(board, 7) == @other_mark && board.turn_count == 4)
    sequence = [ 5, 7, 9, 3, 1, 2, 4, 6, 8] if mark_at(board, 1) == @other_mark && mark_at(board, 8) == @other_mark
    sequence = [ 5, 2, 7, 9, 3, 1, 4, 6, 8] if (mark_at(board, 1) == @other_mark && mark_at(board, 9) == @other_mark) || (mark_at(board, 3) == @other_mark && mark_at(board, 7) == @other_mark)

    (mark_at(board, 5) == @other_mark ? choice = 7 : choice = 5) if board.turn_count == 2

    choice = 3 if board.turn_count == 0

    # This part checks for any winning moves
    sequence.each do |position|
      target_cell = board.get_cell(position) #### change all cells
      if target_cell.mark == ' ' &&
        relevant_lines(target_cell, winning_lines).any?{ |line|
          line.count{ |cell| cell.mark == @x_or_o} == 2}
        puts 1
        choice = position
        break
      end
    end
    #makes sure they're not about to win!
    unless choice
      sequence.each do |position|
        target_cell = board.get_cell(position)
        if target_cell.mark == ' ' &&
          relevant_lines(target_cell, winning_lines).any?{ |line|
           line.count{ |cell| cell.mark == @other_mark} == 2}
          puts 2
          choice = position
          break
        end
      end
    end
    # checks for any line with one of own mark and two blanks
    unless choice
        sequence.each do |position|
        target_cell = board.get_cell(position)
        if target_cell.mark == ' ' &&
          relevant_lines(target_cell, winning_lines).any?{ |line|
            line.any?{ |cell| cell.mark == @x_or_o} &&
            line.count{ |cell| cell.mark == ' '} == 2}
          choice = position
          puts 3
          break
        end
      end
    end
    # if none of above follows the simple 'sequence' routine to find the first free cell
    unless choice
      sequence.each do |position|
        if board.get_cell(position).mark ==' '
          choice = position
          puts 4
          break
        end
      end
    end
    choice
  end
end