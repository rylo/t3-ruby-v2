require 'spec_helper'

describe Player do
  let(:game) { Game.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE) }
  
  before { Console.set_output(MockOutput.new) }
  before { Console.set_input(MockInput.new) }
  
  it "should have a marker" do
    game.player(1).marker.should == PLAYER1_MARKER
  end
end

describe EasyComputer do
  let(:game) { Game.new(PLAYER1_MARKER, EasyComputer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE) }
  let(:board) { game.board }
  before { Console.set_output(MockOutput.new) }
  
  it "should be a subclass of Player" do
    game.player(1).class.superclass.should == Player
    game.player(1).class.should == EasyComputer
  end
  
  it "#get_move should return a valid space" do
    destination = game.player(1).get_move(board)
    board.valid_move?(destination).should == false
  end
end

