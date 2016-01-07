require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'logic.rb'
require_relative 'computer.rb'
require_relative 'human.rb'


class ConnectFour
   
  def initialize

  	@player_1 = Player.build_human_player("red")  # always human
    @board = Board.new
    @current_player = @player_1
    @logic = Logic.new

  end


  def print_instructions

    puts "====================================================="
    puts " Welcome to Connect Four! The object of the game"
    puts " is to get four pieces in a row. Your pieces can"
    puts " be vertical, horizontal, or diagonal."
    puts "====================================================="

  end

  def ask_player_type
    
    input = ""
    until ["computer","human"].include?(input)  
    	print "Second player is human or computer? :"
    	input = gets.chomp

    	input == "computer"? (@player_2 = Player.build_computer_player("green")) : (@player_2 = Player.build_human_player("green"))
    end

  end

  def switch_player

    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end


  def add_move(move_array,color)

 	  @board.game_board[move_array[0]][move_array[1]] = color

  end


  def play

    print_instructions
    ask_player_type
    @board.render

    loop do
      # get column from user
      column = @current_player.player_move
      # validate_move
      until @board.atleast_one_row_empty?(column)
        puts "That column is full, please try again."
        column = @current_player.player_move
      end
      # combine column with correct row
      move_array = @board.get_move_array(column)
      # make move
      add_move(move_array,@current_player.color)
      # show board
      @board.render
      # see if player has won
      if @logic.straight_win?(@board.game_board,move_array,@current_player.color)
        puts "Congratulations #{@current_player.color}, you win!"
        break
      end
      # switch players
      @current_player = switch_player

    end

  end

end	

game = ConnectFour.new
game.play