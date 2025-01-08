require_relative "instructions.rb"
require_relative "player_maker_breaker_class.rb"
#require_relative "master_mind2.rb"
# The board class instantiates PlayerMaker and PlayerBreaker classes and has methods for setting instance variables, evaluating guesses and executing the game

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

class Board
  include Playable
  attr_accessor :maker_board, :turns, :breaker_board

  def initialize
    @pegs = []
    @maker_board = []
    @breaker_board = []
    @winner = false
    @player_breaker = PlayerBreaker.new
    @player_maker = PlayerMaker.new
    puts "Enter 1 to be the code breaker or 2 to be the code maker"
    @player_choice = gets.chomp
    @turns = 0
  end

  def compare?
    @player_code.each_with_index do |code, index|
      if @secret_code.include?(code)
        if code == @secret_code[index]
          #puts "hi"
          @pegs[index] = "B"
        else
          #puts "ni"
          @pegs[index] = "W"
        end
      else
        #puts "nay"
        @pegs[index] = "?"
      end
    end
    puts @pegs
  end
  
  # if player is breaker, set instance variables
  # 
  def player_is_breaker
    @breaker_board = @player_breaker.player_code
  end

  #if player is maker, set instance variables
  
  def player_is_maker
    @maker_board = @player_maker.player_code
    @breaker_board = @player_maker.computer_code
  end
  
  # computer generates code
  def generate_computer_code
    i = 1
    while i <= 4 do
      value = Playable::POSSIBLE_VALUES.sample
      @maker_board << value
      i += 1
    end
    puts @maker_board
  end

  def check_winner
    if @maker_board == @breaker_board
      @turns = 13
      @winner = true
    end
  end

  def compare_codes?
    @breaker_board.each_with_index do |code, index|
      if @maker_board.include?(code)
        if code == @maker_board[index]
          #puts "hi"
          @pegs[index] = "B"
        else
          #puts "ni"
          @pegs[index] = "W"
        end
      else
        #puts "nay"
        @pegs[index] = "?"
      end
    end
    puts @pegs
  end

  def result
    case @player_choice
    when "1"
      if @winner == true
        puts "Congratulations!! you solved it!"
      else
        puts "The code was #{maker_board.join}. Better luck next time!"
      end
    else
    if @winner == true
      puts "The machine figured it out"
    else
      puts "You beat the machine"
    end
    end
  end

# decide which play method to execute
  def decide_play_method
    case @player_choice
    when '1'
      play_player_breaker
    else
      play_player_maker
    end
  end
 #execute if player is code breaker 
  def play_player_breaker
    generate_computer_code
    until @turns >= 13
      puts "Turn: #{@turns}"
      @player_breaker.get_player_code
      player_is_breaker
      check_winner
      compare_codes?
      @turns += 1
    end
    result
  end
 #execute if player is code maker
  def play_player_maker
    @player_maker.get_player_code
    @player_maker.initial_guess
    compare_codes?
    @turns += 1
    until @turns >= 13
      puts "Turn: #{@turns}"
      @player_maker.second_guess
      player_is_maker
      check_winner
      compare_codes?
      @turns += 1
      sleep(0.25)
    end
    result
  end
end