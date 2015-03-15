
require './computer'
require 'ox'
require './board'

#-------------------
# GAME
#-------------------
class Game

  def initialize
    @current_player, @other_player = start_game
    @board = Board.new
    intro
    @begin = true
    next_turn
  end

  def intro
    print hash_lines
    puts "EXCELLENT! \nSo, #{@current_player.name}, you go first with '#{@current_player.x_or_o}' as your mark. #{@other_player.name}, your mark will be '#{@other_player.x_or_o}'.\nTo play, you need to type in a number between 1 and 9 to enter your mark onto the board.\nThe numbers you enter correspond to the positions shown here:\n"
    print_layout
    puts "This is your blank game board. Follow the instructions to start filling it in:"
  end

  def hash_lines
    "#{"#=" * 40}\n#{"#=" * 40}\n#{"#=" * 40}\n"
  end

  def start_game
    puts "Would you like to start a new game or load a previous game? 'new'/'load'."
    load = get_input.downcase
    if load == 'load'
      loader = GameSave.new
      loader.show_files
      loader.load_game(get_input.to_i - 1)
    end
    puts "Please enter your name then press enter."
     #Weird running .shuffle first here?
    name_one = get_input ###################
    name_two = ['Hal 9000', 'Skynet', 'Cortana', 'kitt', 'Bender', 'GLaDOS', 'GLaDOS', 'GLaDOS', "Her"].sample
    x_or_o = ["X", "O"].shuffle
    player_one, player_two = [Player.new({name: name_one, x_or_o: x_or_o[0]}), Computer.new({name: name_two, x_or_o: x_or_o[1], other_mark: x_or_o[0]})].shuffle
    [player_one, player_two]
  end

  def next_turn
    print_board
    puts "Hey, #{@current_player.name}, it's your turn, you're '#{@current_player.x_or_o}'s. Put your '#{@current_player.x_or_o}' down on the board by choosing a number between 1 and 9. (Type 'help' or 'options' for a list of options)."
    @current_player.is_a?(Computer) ? position = @current_player.choose_move(@board, winning_lines) : position = get_input.to_i
    next_turn unless @board.mark_cell(position, @current_player.x_or_o)
    check_end
    switch_player
    next_turn
  end

  def help
    print hash_lines
    puts "Type 'grid' or 'key' if you need reminding where the numbers go."
    puts "Type 'exit' or 'quit' to exit without saving, or 'save' to save your current game."
    next_turn
  end

  def switch_player
    @current_player, @other_player = @other_player, @current_player
  end

  def get_input######## new class
    print '>> '
    input = gets.chomp
    check_input = input.downcase
    ####### case nested in if
    if check_input == 'grid' || check_input == 'key' || check_input == 'rules'
      puts "Just enter a number to put your mark in these places:"
      print_layout
      check_end
      next_turn
    elsif check_input == 'exit' || check_input == 'quit'
      end_game
    elsif @begin && (check_input == 'help' || check_input == 'options')
      help
    elsif @begin && check_input == 'save'
      GameSave.new({game_data: self, file_name: file_name}).save_game
      end_game
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
    end_win if winning_lines.any? {|row| row.all?{ |mark| mark.to_s == x_or_o}}
    end_draw if @board.turn_count == 9
  end

  def winning_lines
    lines = []#creates empty array for all lines
    @board.grid.each{|row| lines << row} #Adds hor
    @board.grid.transpose.each{|collumn| lines << collumn} #adds vert
    lines << @board.grid.each_with_index.map{|row, index| row[index]} #adds diags
    lines << @board.grid.each_with_index.map{|row, index| row[2 - index]}
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

  def file_name
    file_name = "./game_saves/#{@current_player.name.split(' ').join('_')}_and_#{@other_player.name.split(' ').join('_')}_turn_#{@board.turn_count+1}"
    file_name << '_again' while Dir['./game_saves/*.xml'].include?(file_name + '.xml')
    file_name << ".xml"
  end

end

#-------------------
# GAME - SAVE
#-------------------

class GameSave

  def initialize(settings_hsh = {})
    @game_data = settings_hsh.fetch(:game_data, nil)
    @file_name = settings_hsh.fetch(:file_name, nil)
    @all_save_files = Dir['./game_saves/*.xml']
  end

  def save_game
    puts "Saved as file: #{@file_name[13..-1]}"
    File.open(@file_name, 'w'){|file| file.write(Ox.dump(@game_data))}
    puts "Your game has been successfully saved."
  end

  def show_files
    puts "Choose from one of your save files by typing the number:"
    if @all_save_files.length == 0
      puts "You don't have any saved games. Choose new game next time."
      Game.new
    end
    @all_save_files.each_with_index{|file, index| puts "#{index+1}: #{file[13..-1]}"}
  end

  def load_game(load_choice)
    File.open(@all_save_files[load_choice], 'r'){|file| @game_save_xml = file.read}
    Ox.parse_obj(@game_save_xml).next_turn
  end

end


class Input # Unused class in development
  def initialize(save_settings = {})
    @save_settings = save_settings # Envision using one for each question and making a new one each time I ask a new question
  end

  def get_input
    print '>> '
    response = nil
    input = gets.chomp
    check_input = input.downcase
    if check_input == 'grid' || check_input == 'key' || check_input == 'rules'
      puts "Just enter a number to put your mark in these places:"
      print_layout
      check_end
      next_turn
    elsif check_input == 'exit' || check_input == 'quit'
      end_game
    elsif @begin && (check_input == 'help' || check_input == 'options')
      help
    elsif @begin && check_input == 'save'
      GameSave.new(@save_settings).save_game ### Needs moving to Game
      end_game
    elsif @begin && check_input!= 'y' && check_input!= 'n' && (input.to_i > 9 || input.to_i < 1)
      puts "I don't understand that! Try again"
      check_end
      next_turn
    end
  end
end



Game.new #.next_turn