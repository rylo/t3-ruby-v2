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
    
    if board.ending_move_available?
      destination = board.select_ending_move(self)
    else
      destination = board.open_spaces.shuffle.first
    end
    
    board.set_move(self.marker, destination)
    destination
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