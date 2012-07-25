class Game
  attr_reader :player1, :player2, :board, :current_turn, :observer
  
  def initialize(player1_marker, player2_marker, board_size)
    @player1 = Player.new(player1_marker)
    @player2 = Player.new(player2_marker)
    @board = Board.new(board_size)
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