require 'player'
require 'board'
require 'console'

class Game
  attr_reader :board, :current_player
  
  def initialize(player1_marker, player1_type, player2_marker, player2_type, board_size)
    generate_players(player1_marker, player1_type, player2_marker, player2_type)
    generate_board(board_size)
    set_first_player
  end
  
  def generate_board(board_size)
    @board = Board.new(board_size)
  end
  
  def generate_players(player1_marker, player1_type, player2_marker, player2_type)
    @player1 = player1_type.new(player1_marker)
    @player2 = player2_type.new(player2_marker)
  end
  
  def player(number)
    number == 1 ? @player1 : @player2
  end
  
  def set_first_player
    first_player = 1
    #first_player = Console.ask_for_first_player.to_i
    if player(first_player).nil?
      Console.put_message("Invalid player number.")
      set_first_player
    else
      @current_player = player(first_player)
    end
  end
  
  def set_current_player
    @current_player == @player2 ? @current_player = @player1 : @current_player = @player2
  end
  
  def start_loop
    while !board.game_over?
      board.print_board
      @current_player.get_move(self.board)
      set_current_player
    end
    report_end_state
    board.print_board
  end
  
  def report_end_state
    if board.won?
      board.won_by?(player(1)) ? player = player(1) : player = player(2) 
      message = "Player #{player.marker} wins!"
    elsif board.draw?
      message = "Draw!"
    end
    Console.put_message(message)
  end
  
end

class GameFactory
  def initialize(player1_marker, player1_type, player2_marker, player2_type, board_size)
    @game = Game.new(player1_marker, player1_type, player2_marker, player2_type, board_size)
  end
  
  def get_game
    @game
  end
end




