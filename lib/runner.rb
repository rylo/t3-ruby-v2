require 'game'

class Runner
  attr_reader :game
  
  def initialize
    @game = Game.new('x', UltimateComputer, 'o', UltimateComputer, '3')
    game.start_loop
  end
end