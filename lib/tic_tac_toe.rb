class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "------------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "------------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    puts "------------"
  end

  def input_to_index(input)
    input = input.to_i - 1
  end

  def move(input, char = "X")
    @board[input] = char
  end

  def position_taken?(input)
    !(@board[input].nil? || @board[input] == " ")
  end

  def valid_move?(input)
    !position_taken?(input) && input.between?(0,8)
  end

  def turn_count
    count = 0
    @board.each do |turn|
      if turn != "" && turn != " "
        count += 1
      end
    end
    return count
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def turn
    puts "Please enter a value between 1-9"
    input = gets.strip
    input = input_to_index(input)
    if valid_move?(input)
      move(input, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.find do |win_combination|
      @board[win_combination[0]] == @board[win_combination[1]] && @board[win_combination[1]] == @board[win_combination[2]] && position_taken?(win_combination[0])
    end
  end

  def full?
    @board.all? do |space|
      space == "X"  || space == "O"
    end
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    WIN_COMBINATIONS.find do |win_combination|
      if @board[win_combination[0]] == @board[win_combination[1]] && @board[win_combination[1]] == @board[win_combination[2]] && position_taken?(win_combination[0])
        return @board[win_combination[0]]
      end
    end
  end

  def play
    until over?
      turn
    end

    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end
