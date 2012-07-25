require 'player'
require 'board'

class Game
  attr_reader :player1, :player2, :board, :current_turn, :current_player, :observer
  
  def initialize(player1_marker, player2_marker, board_size)
    @player1 = Player.new(player1_marker)
    @player2 = Player.new(player2_marker)
    @board = Board.new(board_size)
    @current_turn = 1
    set_current_player
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
    player_markers = [player1.marker, player2.marker]
    filled_spots = []

    player_markers.each do |player_marker|
      player_taken_spaces = []
      board.grid.each_with_index do |space_content, space_number|
        player_taken_spaces << space_number if space_content == player_marker
      end
      player_taken_spaces = player_taken_spaces.combination(board.size).to_a
      
      board.grid.each_with_index do |space_content, space_number|              
        filled_spots << space_number if space_content == player_marker
      end
      
      winning_row = (player_taken_spaces & board.rows).first
      return winning_row if board.rows.include?(winning_row)
    end
  end
  
  def start_loop
    destinations = [0..8]
    'started'
  end
end