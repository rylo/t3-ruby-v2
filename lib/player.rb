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

class HardComputer < Player  
  def get_move(board)
    super
    
    destination = find_best_move(board)  
    board.set_move(self.marker, destination)
  end
  
  def find_best_move(board)
    best_score = -99
    best_spots = []
      
    board.open_spaces.each do |open_space|
      opponent = get_other_player(self.marker)
      board.set_move(opponent, open_space)      
      score = minimax(board, opponent)
      
      if score >= best_score
        best_score = score
        best_score != score ? best_spots = [open_space] : best_spots << open_space
      end
      board.clear_space(open_space)
    end

    return best_spots.shuffle.first
  end
    
  def minimax(board, player_marker)
    best_score = -99999
    best_spot = -1

    if board.draw? || board.won?
      best_score = get_score(board, player_marker)
    else
      board.open_spaces.shuffle.each do |open_space|
        board.set_move(self.marker, open_space)
        opponent = get_other_player(player_marker)
        score = -minimax(board, opponent)

        if score > best_score
          best_score = score
        end
        board.clear_space(open_space)
      end
    end
    
    return best_score
  end
  
  def get_score(board, marker)
    opponent_marker = get_other_player(marker)
    
    if board.draw?
      return 0
    else 
      if board.won_by?(marker)
        return 2
      else
        return 1
      end
    end
  end
  
  def get_other_player(marker)
    marker == 'x' ? 'o' : 'x'
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