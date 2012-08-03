require 'spec_helper'

describe Console do
  let(:console) { Console }
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:board) { game.board }
  
  before { Console.set_output(MockOutput.new) }
  before { Console.set_input(MockInput.new) }
  
  it "accepts user input" do
    console.get_user_input
    console.input.last_message.should == "0"
  end
  
  it "asks for a user to make a move" do
    console.ask_for_input
    console.output.last_message.should == "Please enter a move: "
  end
  
  it "should put_message" do
    console.put_message("Invalid move.")
    console.output.last_message.should == "Invalid move."
  end
  
  it "allows me to set output" do
    fake = stub
    console.set_output(fake)
    console.output.should == fake
  end
end