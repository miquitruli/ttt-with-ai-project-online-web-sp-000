module Players
  class Human < Player
    def move(board)
      puts "Hello! Please make your move (1-9)" #ask for input
      move = gets.chomp #get input
    end
  end
end
