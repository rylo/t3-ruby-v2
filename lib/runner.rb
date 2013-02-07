require 'game'

class Runner  
  def start
    game.start_loop
  end
  
  def game
    Game.new('x', HumanPlayer, 'o', UltimateComputer, '3', ConsoleUI)
  end
end