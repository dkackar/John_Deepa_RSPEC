class Human < Player


  def player_move
    puts "====================================================="
    puts "  Please enter the COLUMN to drop your coin."
    puts "  Valid columns are 0 thru 6."
    puts "====================================================="
    puts "#{@color} player enter your COLUMN:"
    
    column = gets.chomp
    until column =~ /[0-6]/
      puts "Column in invalid format!, Re-Enter: "
      column = gets.chomp
    end 
    column = column.to_i
  end


end