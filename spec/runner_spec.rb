require 'spec_helper'

describe Runner do
  let(:runner) { Runner.new }
  let(:game) { Game.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE, ConsoleUI) }
  
  before { ConsoleUI.set_output(MockOutput.new) }
  before { ConsoleUI.set_input(MockInput.new) }
  
  it "should create a game" do
    pending "figuring out how to test if the runner ran?"
    runner.game.should_not be_nil
  end
end