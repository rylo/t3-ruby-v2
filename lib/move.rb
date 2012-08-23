require 'config'

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