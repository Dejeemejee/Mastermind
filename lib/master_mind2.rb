
class Game_Board
  
  #@@bd = Array.new()
  @@player_code = Array.new(4) {}
  @@board = []
  def initialize
      @secret_code = []
      @pegs = []
  end

  def make_code
    4.times do |num|
     @secret_code[num] = rand(1..4)
   end
   p  @secret_code
  end

  def get_code
    for i in 0..3
     # until /\d/.match?(@player_code[i])
      #end
      @@player_code[i] = gets.chomp.to_i
    end
    @@board <<= @@player_code
    p @@board
  end
  
  
  def compare_codes?
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
    display_board
  end



  def display_board
    @board.each do |row|
     puts "#{row} #{@pegs}"
  end
  end

  
  
  
end

#game.get_code
#game.compare_codes?
#game.check_progress?
#game.get_code
#
#
class Game
  def initialize
    @game = Game_Board.new()
  end
  
  def play
    3.times do
      @game.make_code
      @game.get_code
     # @game.compare_codes?
     # @game.check_progress?
    end
  end
end

game_play = Game.new
game_play.play