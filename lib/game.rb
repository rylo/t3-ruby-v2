class Game
  attr_reader :player1, :player2, :board, :current_turn, :observer
  
  def initialize(player1_marker, player2_marker, board_size)
    @player1 = Player.new(player1_marker)
    @player2 = Player.new(player2_marker)
    @board = Board.new(board_size)
    @observer = Observer.new
    @current_turn = 1
  end
  
  def increment_turn
    @current_turn += 1
  end
  
  def check_for_win
    board = self.board
    player_markers = [self.player1.marker, self.player2.marker]
    filled_spots = []

    player_markers.each do |player_marker|      
      board.grid.each_with_index do |space_content, space_number|              
        filled_spots << space_number if space_content == player_marker
      end
      if board.rows.include?(filled_spots)
        return 'someone won'
      else
        return 'nobody has won yet'
      end
    end    
  end
end

class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
end

class Board
  attr_reader :size, :grid, :rows
  
  def initialize(board_size)
    @size = board_size.to_i
    @grid = Array.new
    (@size ** 2).times { @grid << '' }
    self.generate_playable_rows
  end
  
  def generate_playable_rows
    @rows = []
    @grid_space_numbers = []
    
    self.grid.each_with_index { |space_number, index| @grid_space_numbers << index }
    
    self.generate_horizontal_rows
    self.generate_diagonal_rows
    self.generate_vertical_rows
  end
  
  def generate_horizontal_rows
    @horizontal_rows = []
    @grid_space_numbers.each_slice(@size) { |grid_space| @horizontal_rows << grid_space }
    @rows += @horizontal_rows
  end
  
  def generate_diagonal_rows
    guides = [@horizontal_rows, @horizontal_rows.reverse]
    
    guides.each do |guide|
      @diagonal_rows = []
      guide.each_with_index {|row, index| @diagonal_rows << row[index]}
      @rows << @diagonal_rows
    end
  end

  def generate_vertical_rows
    row_starting_spaces = @horizontal_rows[0]
    
    row_starting_spaces.each do |starting_space|
      vertical_rows = []
      vertical_rows << starting_space
      (@size-1).times.with_index do |index|
        space = starting_space + (@size*(index+1))
        vertical_rows << @grid_space_numbers[space]
      end
      @rows << vertical_rows
    end
    
    @rows
  end
end

class InvalidMoveError < RuntimeError; end

class Move
  attr_reader :board, :player_marker, :destination
  
  def initialize(game, player_marker, destination)
    @board = game.board
    @player_marker = player_marker
    @destination = destination.to_i
    
    if board.grid[@destination].length == 0
      board.grid[@destination] = player_marker
      game.increment_turn
    else
      raise InvalidMoveError, "Destination taken on grid."
    end
  end
end

class Observer
  def initialize
    
  end
end