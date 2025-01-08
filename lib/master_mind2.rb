require_relative "instructions.rb"
require_relative "board_class.rb"
#require_relative "player_maker_breaker_class.rb"

module Playable
  POSSIBLE_VALUES = ["1", '2', '3', '4']

  def get_player_code
    puts "Enter your code: four numbers(1 through 4) in a row on one line"
    input = gets.chomp
    until input.length == 4 && input.each_char.map{|i| i.to_i}.all?{|i| i >= 1 && i <= 4}
      puts "Enter a valid code!!!!!"
      input = gets.chomp
    end

    @player_code = input.split('')
  end
end




class Game
  attr_accessor :board

  def initialize
    @board = Board.new()
  end
  
  def play_again
    puts "Enter Y play again or N to end"
    answer = gets.chomp
    case answer
    when "y"
      @board = Board.new
      @board.decide_play_method
      play_again
    when "Y"
      @board = Board.new
      @board.decide_play_method
      play_again
    else
      puts "Thanks for playing"
    end
  end
  
end

#Instructions
get_game_instructions()

game_play = Game.new
game_play.board.decide_play_method
game_play.play_again