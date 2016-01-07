require_relative 'board.rb'

class Logic

  @@BACKWARD_DIAGONALS = [
    [[2,0], [3,1], [4,2], [5,3]],
    [[1,0], [2,1], [3,2], [4,3], [5,4]],
    [[0,0], [1,1], [2,2], [3,3], [4,4], [5,5]],
    [[0,1], [1,2], [2,3], [3,4], [4,5], [5,6]],
    [[0,2], [1,3], [2,4], [3,5], [3,6]],
    [[0,3], [1,4], [2,5], [3,6]]
  ]

  @@FORWARD_DIAGONALS = [
    [[3,0], [2,1], [1,2], [0,3]],
    [[4,0], [3,1], [2,2], [1,3], [0,4]],
    [[5,0], [4,1], [3,2], [2,3], [1,4], [0,5]],
    [[5,1], [4,2], [3,3], [2,4], [1,5], [0,6]],
    [[5,2], [4,3], [3,4], [2,5], [1,6]],
    [[5,3], [4,4], [3,5], [2,6]]
 ]
  def initialize
    @board = Board.new
  end

  def check_diagonals(diagonal_array,array, color, move)

    diagonal_array.each do |diagonal|
      # user's move is in potential diagonal
      arr = []

      if diagonal.include? move  # move
        #get the actual colors from the game board based on
        #positional array
        diagonal.each do |item|
          arr << array[item[0]][item[1]]
        end
        
        # check if 4 consecutive items in diagonal are the same
        return true if horizontal_vertical_win?(arr, color) 
      end
    end
    return false
  
  end

  def straight_win?(array,move,color)
    
    user_row = move[0]
    user_col = move[1]

    # check horizontal rows
    return true if horizontal_vertical_win?(array[user_row],color)
    # check vertical rows
    return true if horizontal_vertical_win?(array.collect {|row| row[user_col]},color)  
    #check backslash diagonals
    return true if check_diagonals(@@BACKWARD_DIAGONALS,array, color, move)
    #check forwardslash diagonals
    return true if check_diagonals(@@FORWARD_DIAGONALS,array, color, move)
  end
    



  def horizontal_vertical_win?(array, color)
    # [0 1 2 3 4 5 6]
    # [r r g g r r r ]
    consecutive = 0
    array.each_with_index do |column, index|
      if array[index] == color
        consecutive += 1
        return true if consecutive == 4
      else
        consecutive = 0
      end
    end
    false
  end


end

move = [2,4]
arr =   [[nil,"r","g","r","r","r","r"],
         ["r","r","g",nil,"r","r","r"],
         ["g","r","g","r","r","r","r"],
         ["g","r","g",nil,"r","r","r"],
         ["g","r","g","r","r",nil,"r"],
         ["r",nil,"g","r","r","r","r"],
         ["r","r","g","r","r","r","r"],
         ["r","r","g","r","r","r","r"]]

