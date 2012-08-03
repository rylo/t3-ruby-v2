require 'spec_helper'

describe Console do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:board) { game.board }
  
  before { Console.set_output(MockOutput.new) }
  
  it "accepts user input" do
    pending "making inputs work with the mock console"
    Console.get_user_input.should_not be_nil
  end
  
  it "asks for a user to make a move" do
    Console.ask_for_input
    Console.output.messages.last.should == "Please enter a move: "
  end
  
  it "should put_message" do
    Console.put_message("Invalid move.")
    Console.output.messages.last.should == "Invalid move."
  end
  
  it "allows me to set output" do
    fake = stub
    Console.set_output(fake)
    Console.output.should == fake
  end
end