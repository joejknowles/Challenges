
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
    @other_mark
  end

  def choose_move(board)
    choice = nil
    #
    [ 5, 1, 3, 7, 9, 2, 4, 6, 8].each do |position|
      if position % 2 == 1 && board.get_cell(position).mark == ' ' && (((board.grid.each_with_index.map{|row, index| row[index]}.count{ |mark| mark.to_s == @x_or_o} == 2) && (position == 1 || position == 9)) || ((board.grid.each_with_index.map{|row, index| row[2-index]}.count{ |mark| mark.to_s == @x_or_o} == 2) && (position == 3 || position == 7)))
        puts 1
        choice = position
        break
      elsif board.get_cell(position).mark == ' ' && ((board.grid[(position -1) / 3].count{|mark| mark.to_s == @x_or_o} == 2) || (board.grid.transpose[(position -1) % 3].count{|mark| mark.to_s == @x_or_o} == 2) )
        puts 2
        choice = position
        break
      end
    end
    unless choice
      [5, 1, 3, 7, 9, 2, 4, 6, 8].each do |position|
        if position % 2 == 1 && board.get_cell(position).mark == ' '    && ((board.grid.each_with_index.map{|row, index| row[index]}.any?{ |mark| mark.to_s == @x_or_o} && (position == 1 || position == 9) && (board.grid.each_with_index.map{|row, index| row[index]}.count{|mark| mark.to_s == ' '} == 2)) || (board.grid.each_with_index.map{|row, index| row[2-index]}.any?{ |mark| mark.to_s == @x_or_o} && (position == 3 || position == 7) && (board.grid.each_with_index.map{|row, index| row[2-index]}.count{|mark| mark.to_s == ' '} == 2)))
          puts 3
        choice = position
        break
        elsif board.get_cell(position).mark == ' ' && (board.grid[(position -1) / 3].any?{|mark| mark.to_s == @x_or_o} || board.grid.transpose[(position -1) % 3].any?{|mark| mark.to_s == @x_or_o}  ) && ((board.grid[(position -1) / 3].count{|mark| mark.to_s == ' '} == 2) || (board.grid.transpose[(position -1) % 3].count{|mark| mark.to_s == ' '} == 2) )
          puts 4
          choice = position
          break
        end
      end
    end
    unless choice
      [5, 1, 3, 7, 9, 2, 4, 6, 8].each do |position|
        if board.get_cell(position).mark ==' '
          puts 5
          choice = position
          break
        end
      end
    end
    choice
  end
end
