require 'player'
require 'board'
require 'console'

class Game
  attr_reader :board, :current_turn, :current_player, :end_condition
  
  def initialize(player1_marker, player2_marker, board_size)
    generate_players(player1_marker, player2_marker)
    generate_board(board_size)
    set_current_player
    
    @current_turn = 1
    @end_condition = nil
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
  
  def set_end_condition(condition)
    @end_condition = condition
  end
  
  def increment_turn
    @current_turn += 1
    set_end_condition("Draw!") if @current_turn > @board.grid.count
  end
  
  def check_for_win
    board = self.board
    player_markers = [player(1).marker, player(2).marker]

    player_markers.each do |player_marker|
      player_taken_spaces = []
      board.grid.each_with_index { |space_content, space_number| player_taken_spaces << space_number if space_content == player_marker }
      winning_row = ( player_taken_spaces.combination(board.size).to_a.sort! & board.rows ).first
      if board.rows.include?(winning_row)
        set_end_condition("Player #{player_marker} wins!")
        return winning_row
      end
    end
  end
  
  def get_move
    board = self.board
    Console.put_message("Player #{current_player.marker}'s turn.")
    destination = Console.ask_for_input
    get_move if board.validate_move(destination) == "invalid"
    board.set_move(@current_player.marker, destination)
  end
  
  def start_loop
    while @end_condition.nil?
      board.print_board
      get_move
      increment_turn
      set_current_player
      check_for_win
    end
    Console.put_message(@end_condition)
    board.print_board
  end
  
end