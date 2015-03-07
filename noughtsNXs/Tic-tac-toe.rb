require 'ox'

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
  end
end

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
end
#-------------------
# GAME
#-------------------
class Game
  def initialize
    @current_player, @other_player, save = start_game
    @board = Board.new(save)
    intro
    @begin = true
    next_turn
  end

  def intro
    40.times{ print "#="}
    puts""
    40.times{ print "#="}
    puts""
    40.times{ print "#="}
    puts""
    puts "EXCELLENT! \nSo, #{@current_player.name}, you go first with '#{@current_player.x_or_o}' as your mark. #{@other_player.name}, your mark will be '#{@other_player.x_or_o}'.\nTo play, you need to type in a number between 1 and 9 to enter your mark onto the board.\nThe numbers you enter correspond to the positions shown here:\n"
    print_layout
    puts "This is your blank game board. Follow the instructions to start filling it in:"
  end

  def start_game
    puts "Would you like to start a new game or load a previous game? 'new'/'load'."
    save = get_input.downcase
    save == 'load' ?  load_game : save = {}
    puts "Please enter your name then press enter, and repeat for the other player."
    names = [get_input, get_input]
    name_one, name_two = names.shuffle
    x_or_o = ["X", "O"].shuffle
    player_one = Player.new({name: name_one, x_or_o: x_or_o[0]})
    player_two = Player.new({name: name_two, x_or_o: x_or_o[1]})
    [player_one, player_two, save]
  end

  def next_turn
    name = @current_player.name
    x_or_o = @current_player.x_or_o
    print_board
    puts "Hey, #{name}, it's your turn, you're '#{x_or_o}'s. Put your '#{x_or_o}' down on the board by choosing a number between 1 and 9. (Type 'rules', 'grid' or 'key' if you need help!)"
    position = get_input.to_i
    next_turn unless @board.mark_cell(position, x_or_o)
    check_end
    switch_player
    next_turn
  end

  def switch_player
    @current_player, @other_player = @other_player, @current_player
  end

  def get_input
    print '>> '
    input = gets.chomp
    check_input = input.downcase
    if check_input == 'grid' || check_input == 'key' || check_input == 'rules'
      puts "Just enter a number to put your mark in these places:"
      print_layout
      check_end
      next_turn
    elsif check_input == 'exit' || check_input == 'quit'
      exit
    elsif @begin && check_input == 'save'
      save_game
    elsif @begin && check_input!= 'y' && check_input!= 'n' && (input.to_i > 9 || input.to_i < 1)
      puts "I don't understand that! Try again"
      check_end
      next_turn
    end
    input
  end

  def print_board
    print "\n"
    (0..2).each do |line|
      @board.grid[line].each_with_index { |val, i| i == 2 ? print(" #{val} \n") : print(" #{val} |")}
      11.times{print "-"} unless line == 2
      print "\n"
    end
  end

  def print_layout
    print "\n"
    first = 1
    (0..2).each do |line|
      (line*3+1..line*3+3).each_with_index { |val, i| i == 2 ? print(" #{val} \n") : print(" #{val} |")}
      11.times{print "-"} unless line == 2
      print "\n"
    end
  end
  def check_end
    x_or_o = @current_player.x_or_o
    end_win if @board.grid.any? {|row| row.all?{ |mark| mark.to_s == x_or_o}} || @board.grid.transpose.any? {|row| row.all?{ |mark| mark.to_s == x_or_o}} || @board.grid.each_with_index.map{|row, index| row[index]}.all?{ |mark| mark.to_s == x_or_o}  || @board.grid.each_with_index.map{|row, index| row[2-index]}.all?{ |mark| mark.to_s == x_or_o}
    end_draw if @board.turn_count == 9
  end
  def end_win
    print_board
    puts "WOW, #{@current_player.name}, you actually won."
    end_game
  end
  def end_draw
    print_board
    puts "Looks like this one's a draw."
    end_game
  end
  def end_game
    puts "Would you like to play again? y/n"
    print '>> '
    case gets.chomp
    when 'y'
      Game.new
    when 'n'
       exit
    end
    puts " I didn't quite catch that!"
    end_game
  end
  def save_game
    file_name = "./game_saves/#{@current_player.name.split(' ').join('_')}_and_#{@other_player.name.split(' ').join('_')}_turn_#{@board.turn_count+1}"
    file_name = file_name << '_again' while Dir['./game_saves/*.xml'].include?(file_name + '.xml')
    file_name = file_name << ".xml"
    puts "Saved as file: #{file_name[13..-1]}"
    File.open(file_name, 'w'){|file| file.write(Ox.dump(self))}
    $game_save = Ox.dump(self)
    puts "Your game has been successfully saved."
    end_game
  end
  def load_game
    puts "Choose from one of your save files by typing the number:"
    all_save_files = Dir['./game_saves/*.xml']
    if all_save_files.length == 0
      puts "You don't have any saved games. Choose new game next time."
      Game.new
    end
    all_save_files.each_with_index{|file, index| puts "#{index+1}: #{file[13..-1]}"}
    load_choice = get_input.to_i - 1
    game_save = all_save_files[load_choice]
    game_save_xml = 0
    File.open(game_save, 'r'){|file| game_save_xml = file.read}
    Ox.parse_obj(game_save_xml).next_turn
  end
end

Game.new