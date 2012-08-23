require 'game'

class Runner
  attr_reader :game
  
  def initialize
    @game = Game.new('x', HardComputer, 'o', HardComputer, '3')
    game.start_loop
  end
end