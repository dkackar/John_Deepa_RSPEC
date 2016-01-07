class Player
    COLORS = {"red"=>1, "green"=>2}

    attr_accessor :type
    attr_accessor :color
    attr_accessor :turn 

	def initialize(type,color)
	    @type = type
	    @turn = false
	    @color =  COLORS[color]
	end

	private_class_method :new

	def self.build_human_player(color)
		new(:human,color)
	end

	def self.build_computer_player(color)
		new(:computer,color)
	end

end


class Game
    
    ROWS = 6
    COLS = 7

    attr_accessor :game_board

	def initialize
      @game_board = Array.new(ROWS){Array.new(COLS,nil)}
	end

    def render
    end

    def check_winning_move(row,col,color)
    	return true if horizontal_win?(row,col,color)
    	return true if vertical_win?(row,col,color)

    end 	

    def horizontal_win?(row,col,color)

      adjacent_colors = 1
      
      - - - -
      upto_col = (col + 3) < COLS - 1 ? (col + 3) : COLS - 1

      (col+1).upto(upto_col).times do |current_col|
    	  if @board_game[row][current_col] == color
    	     adjacent_colors += 1
    	  else 
    	     break
    	  end
       end	  
       
       return true if adjacent_colors == 4
    
       
       left_col = current_col - adjacent_colors - 1
       need = 4 - adjacent_colors
       
       downto_col = (left_col - need) > 0 ? (left_col - need): 0
    	 left_col.downto(downto_col).times do |current_col|
    	
    	 if @board_game[row][current_col] == color
    	    adjacent_colors += 1
    	 end
       
       end	 
       
       return true if adjacent_colors == 4

    end

    def vertical_win?(row,col,color)

      adjacent_colors = 1

      upto_row = \
      (row+3) < ROWS - 1? (row+3): ROWS - 1

      (row+1).upto(upto_col).times do |current_row|
    	  if @board_game[current_row][col] == color
    	     adjacent_colors += 1
    	  else 
    	     break
    	  end
       end	  
       
       return true if adjacent_colors == 4
    
       
       downto_row = current_row - adjacent_colors - 1
       need = 4 - adjacent_colors
       
       downto_row = \
         (down_row_col - need) > 0 ? (down_row - need): 0
    	 down_row.downto(downto_row).times do |current_row|
    	
    	 if @game_board[current_row][col] == color
    	    adjacent_colors += 1
    	 end
       
       end
       
       return true if adjacent_colors == 4

    end  
end

class ConnectFour

  attr_accessor :player1
  attr_accessor :player2	
  
  def initialize
  	#color = get_player_color() 
   
    @player1 = Player.build_human_player("red")
    @player2 = Player.build_human_player("green")
    @player1.turn = true
	@player2.turn = false
	@player = @player1

	print "Enter row:"
	print "Enter col:"
 

	@game_status = Game.new
 
  end

  def play
  	row = 0
  	col = 0
    loop do

	  if @player1.turn
	     @game_status.game_board[row][col] = @player1.color
	  else 
	    @game_status.game_board[row][col] = @player2.color 
	  end  
	  print "Won the game" if @game_status.check_winning_move(row,col,@player.color)  
      
	  @player1.turn = !@player1.turn
	  @player2.turn = !@player2.turn
	  
    end   
  end
end

game = ConnectFour.new
game.play
