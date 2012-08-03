gem 'rspec'

require 'game'
require 'board'
require 'player'
require 'runner'
require 'console'

PLAYER1_MARKER = 'x'
PLAYER2_MARKER = 'o'
BOARD_SIZE = 3

MOCK_INPUT = '0'



class MockOutput
  attr_reader :messages
  
  def initialize
    @messages ||= []
  end
  
  def last_message
    messages.last
  end
  
  def puts(message)
    @messages << message
  end
end

class MockInput
  attr_reader :messages
  
  def initialize
    @messages ||= []
  end
  
  def last_message
    messages.last
  end
  
  def gets
    @messages << MOCK_INPUT
    MOCK_INPUT
  end
end