require_relative 'player'
require_relative 'board'
require_relative 'console'
require_relative 'rules'

class Game
  attr_reader :board, :rules, :current_player, :ui
  
  def initialize(player1_marker, player1_type, player2_marker, player2_type, board_size, ui)
    generate_players(player1_marker, player1_type, player2_marker, player2_type)
    generate_board(board_size)
    set_first_player
    set_ui(ui)
    set_rules
  end

  def generate_players(player1_marker, player1_type, player2_marker, player2_type)
    @player1 = player1_type.new(player1_marker)
    @player2 = player2_type.new(player2_marker)
  end

  def generate_board(board_size)
    @board = Board.new(board_size)
  end
  
  def set_ui(ui)
    @ui = ui
  end
  
  def set_rules
    @rules = Rules.new
  end

  def player(number)
    number == 1 ? @player1 : @player2
  end
  
  def set_first_player
    first_player = 1
    #first_player = @ui.ask_for_first_player.to_i
    if player(first_player).nil?
      @ui.put_message("Invalid player number.")
      set_first_player
    else
      @current_player = player(first_player)
    end
  end
  
  def set_current_player
    @current_player == @player2 ? @current_player = @player1 : @current_player = @player2
  end
  
  def start_loop
    until rules.game_over?(board)
      @ui.put_message(board.printable_board)
      @ui.put_message("#{@current_player.marker}'s turn.")
      @current_player.get_move(self)
      set_current_player
    end
    @ui.put_message(report_end_state)
    @ui.put_message(board.printable_board)
  end
  
  def report_end_state
    if @rules.won?(@board)
      @rules.won_by?(@board, player(1).marker) ? player = player(1) : player = player(2) 
      message = "Player #{player.marker} wins!"
    elsif @rules.draw?(@board)
      message = "Draw!"
    end
    message
  end
  
end

class GameFactory
  def initialize(player1_marker, player1_type, player2_marker, player2_type, board_size, ui)
    @game = Game.new(player1_marker, player1_type, player2_marker, player2_type, board_size, ui)
  end
  
  def get_game
    @game
  end
end




