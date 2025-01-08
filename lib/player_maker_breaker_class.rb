require_relative "instructions.rb"
#require_relative "board_class.rb"
#require_relative "master_mind2.rb"

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

class PlayerBreaker
  include Playable
  attr_accessor :player_code

  def initialize
    @player_code = []
  end
end

class PlayerMaker
  include Playable
  attr_accessor :player_code, :computer_code

  def initialize
    @player_code = []
    @computer_code = []
  end

  def initial_guess
    value = Playable::POSSIBLE_VALUES.sample
    i = 1
    while i <= 4 do
      @computer_code << value
      i += 1
    end
    #puts "Computer guessed #{@computer_code}"
  end

  def second_guess
    new_guess = []

    i = 0
    while i <= 3 do
      if @player_code[i] = @computer_code[i]
        new_guess << @player_code[i]
      else
        value = Playable::POSSIBLE_VALUES.sample
        new_guess << value
      end
       i += 1
    end
    @computer_code = new_guess
    puts "Computer guessed #{computer_code}"
  end
end