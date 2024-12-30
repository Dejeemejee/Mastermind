#require 'pry-byebug'

class Game_Board
  
  attr_accessor :secret_code, :player_code, :board, :pegs   

  def initialize
    @secret_code = 
    @player_code = []
    @board =  Array.new()
    @pegs = Array.new()
  end

  def make_code
    4.times do |num|
      @secret_code[num] = rand(1..4)
   end
   return @secret_code
  end

  def get_code
    for i in 0..3
      @player_code[i] = gets.chomp.to_i
    end
   @board.unshift(@player_code)
   display_board1()
  end

  def compare_codes?
    @secret_code.each_with_index do |code, index|
      if @player_code.include?(code) &&  code == @player_code[index]
        @pegs[index] = "B"
        display_board1()
      elsif @player_code.include?(code) &&  !(code == @player_code[index])
        @pegs[index] = "W"
        display_board1()
      else
        @pegs[index] = "?"
        display_board1()
      end
    end
  end

  def check_progress?
    @player_code == @secret_code ? true : false
  end


  def display_board
    @board.each do |row|
      puts "#{row} #{@pegs}"
    end
  end

end

Game_Board.new 

class Game
  def initialize
    @game = Game_Board.new()
  end
   
  def play
    until @game.check_progress? || @game.board.count() == 7
      @game.make_code
      @game.get_code
      @game.compare_codes
    end
    

    if @game.check_progress?
      puts "Congratulations!!! You broke the code"
    else 
      puts "Do better"
    end
  end
  

end

game_play = Game.new()
game_play.play