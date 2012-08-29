class Player
  attr_reader :marker
  
  def initialize(marker)
    @marker = marker
  end
  
  def get_move(board)
    Console.put_message("Player #{self.marker}'s turn.") #extract?
  end
end

class EasyComputer < Player  
  def get_move(board)
    super
    
    destination = board.open_spaces.shuffle.first
    board.set_move(self.marker, destination)
    destination
  end
end

class UltimateComputer < Player  
  def get_move(board)
    super
    
    destination = find_best_move(board)  
    board.set_move(self.marker, destination)
  end
  
  def find_best_move(board)
    best_score = -99
    best_spots = []
    
    return 4 if board.open_spaces.count == (board.size ** 2)
    
    board.open_spaces.each do |open_space|
      opponent = get_other_player(self.marker)
      board.set_move(self.marker, open_space)
      board.open_spaces.count == (board.size ** 2) && open_space == 4 ? score = 1000 : score = -minimax(board, opponent, depth = 0)      
      board.clear_space(open_space)
      
      if score >= best_score
        if best_score == score
          best_spots << open_space
        elsif score > best_score
          best_spots = []
          best_spots << open_space
        end
        best_score = score
      end
    end
    return best_spots.shuffle.first
  end
    
  def minimax(board, player_marker, depth)
    best_score = -99
    best_spot = -1

    if board.draw? || board.won? || depth == 3
      best_score = get_score(board, player_marker) * depth_score(depth)
    else
      board.open_spaces.shuffle.each do |open_space|
        board.set_move(player_marker, open_space)
        
        opponent = get_other_player(player_marker)
        score = -minimax(board, opponent, depth + 1)
        board.clear_space(open_space)
        
        best_score = score if score > best_score
      end
    end
    
    return best_score
  end
  
  def get_score(board, player_marker)
    opponent_marker = get_other_player(player_marker)
    multiplier = 0.20
    
    if board.won?
      board.won_by?(player_marker) ? 100 : -100
    elsif board.ending_move_available?
      board.winning_move_available?(player_marker) ? multiplier * board.winning_moves(player_marker).count : -multiplier * board.winning_moves(opponent_marker).count 
    else
      return 0
    end
  end
  
  def get_other_player(marker)
    marker == 'x' ? 'o' : 'x'
  end
  
  def depth_score(depth)
   depth = depth - ((depth-2)*2)
  end
  
end

class HumanPlayer < Player
  def get_move(board)
    super 
    
    destination = Console.ask_for_input
    if !board.valid_move?(destination)
      get_move(board)
    else
      board.set_move(self.marker, destination)
      destination
    end
  end
end