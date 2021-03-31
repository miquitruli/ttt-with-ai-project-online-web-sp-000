class Game
  attr_accessor :board, :player_1, :player_2, :input
  WIN_COMBINATIONS = [
  [0,1,2], # top_row
  [3,4,5], # middle_row
  [6,7,8], # bottom_row
  [0,3,6], # left_column
  [1,4,7], # center_column
  [2,5,8], # right_column
  [0,4,8], # left_diagonal
  [6,4,2] # right_diagonal
]
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board=Board.new)
    #provides access to board, player_1 and player_2
    @board = board
    @player_1 = player_1
    @player_2 = player_2
  end

  def current_player
    #returns the correct player, X, for the third move
    @board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def draw?
    @board.full? && !won?
  end

  def won?
    WIN_COMBINATIONS.detect do |index| #values_at returns the values for the corresponding indices (* transforms the indices array to a list of arguments, so values_at(*[0,1,2]) becomes values_at(0,1,2)).
      @board.cells[index[0]] == @board.cells[index[1]] &&#how we refer to our first cells of the WIN_COMBINATION nested array
      #if checking [6,4,2] winning position, the syntax above is currently comparing to make sure the token in 6 & 4 are the same
      @board.cells[index[1]] == @board.cells[index[2]] &&#if checking [6,4,2] winning position, the syntax above is currently comparing to make sure the token in 4 & 2 are the same
      (@board.cells[index[0]] == "X" || @board.cells[index[0]] == "O")
    end
  end

  def over?
    won? || draw?
  end

  def winner
    if won = won?
      @winner = @board.cells[won.first]
    end
  end

  def turn
    puts "Please enter a number 1-9:"
    @input = current_player.move(@board)
    if @board.valid_move?(@input)
      @board.update(@input, current_player)
    else puts "Please enter a number 1-9:"
      @board.display
      turn
    end
    @board.display
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
