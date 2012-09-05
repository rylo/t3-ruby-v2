require 'game'

class Runner
  attr_reader :game
  
  def initialize
    @game = Game.new('x', UltimateComputer, 'o', UltimateComputer, '3', ConsoleUI)
    game.start_loop
  end
end