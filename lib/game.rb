require 'player'
require 'board'
require 'console'

class Game
  attr_reader :board, :current_turn, :current_player, :end_condition
  
  def initialize(player1_marker, player1_type, player2_marker, player2_type, board_size)
    generate_players(player1_marker, player1_type, player2_marker, player2_type)
    generate_board(board_size)
    set_first_player
    
    @current_turn = 1
    @end_condition = nil
  end
  
  def generate_board(board_size)
    @board = Board.new(board_size)
  end
  
  def generate_players(player1_marker, player1_type, player2_marker, player2_type)
    @player1 = player1_type.new(player1_marker)
    @player2 = player2_type.new(player2_marker)
  end
  
  def player(number)
    case number
      when 1
        return @player1
      when 2
        return @player2
    end
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
    case @current_player
      when @player2
        @current_player = @player1
      when @player1
        @current_player = @player2
    end
  end
  
  def next_player
    @current_player == @player1 ? @player2 : @player1
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
  
  def start_loop
    while @end_condition.nil?
      board.print_board
      @current_player.get_move(self.board)
      increment_turn
      set_current_player
      check_for_win
    end
    Console.put_message(@end_condition)
    board.print_board
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


















