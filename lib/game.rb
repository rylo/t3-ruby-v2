require 'player'
require 'board'

class Game
  attr_reader :board, :current_turn, :current_player
  
  def initialize(player1_marker, player2_marker, board_size)
    generate_players(player1_marker, player2_marker)
    generate_board(board_size)
    set_current_player
    
    @current_turn = 1
  end
  
  def generate_board(board_size)
    @board = Board.new(board_size)
  end
  
  def generate_players(player1_marker, player2_marker)
    @player1 = Player.new(player1_marker)
    @player2 = Player.new(player2_marker)
  end
  
  def player(number)
    case number
      when 1
        return @player1
      when 2
        return @player2
    end
  end
  
  def set_current_player
    if @current_player.nil?
      @current_player = @player1 
    else
      case @current_player
        when @player2
          @current_player = @player1
        when @player1
          @current_player = @player2
      end
    end
  end
  
  def increment_turn
    @current_turn += 1
  end
  
  def check_for_win
    board = self.board
    player_markers = [player(1).marker, player(2).marker]

    player_markers.each do |player_marker|
      player_taken_spaces = []
      board.grid.each_with_index { |space_content, space_number| player_taken_spaces << space_number if space_content == player_marker }
      winning_row = (player_taken_spaces.combination(board.size).to_a & board.rows).first
      return winning_row if board.rows.include?(winning_row)
    end
  end
  
  def ask_for_move(current_player)
    "Please make a move:"
  end
  
  def start_loop
    while current_turn < self.board.grid.count
      set_current_player
      increment_turn
    end
    'ended'
  end
  
end