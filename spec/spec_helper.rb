gem 'rspec'

require 'game'
require 'board'
require 'player'
require 'runner'
require 'console'

PLAYER1_MARKER = 'x'
PLAYER2_MARKER = 'o'
BOARD_SIZE = 3



class MockOutput
  attr_reader :messages
  
  def initialize
    @messages ||= []
  end
  
  def puts(message)
    @messages << message
  end
end