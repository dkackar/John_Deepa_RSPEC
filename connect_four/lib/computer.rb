class Computer < Player

  def player_move
    column = rand(0..6)
    puts "Computer plays #{column}"
    return column
  end


end