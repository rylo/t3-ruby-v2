require 'spec_helper'

describe ConsoleUI do
  let(:ui) { ConsoleUI }
  let(:game) { Game.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE, ui) }
  let(:board) { game.board }

  before { ui.set_output(MockOutput.new) }
  before { ui.set_input(MockInput.new) }
  
  it "accepts user input" do
    ui.get_user_input
    ui.input.last_message.should == "1"
  end
  
  it "asks for a user to make a move" do
    ui.ask_for_input
    ui.output.last_message.should == "Please enter a move: "
  end
  
  describe "#put_message" do
    it "should put_message" do
      ui.put_message("Invalid move.")
      ui.output.last_message.should == "Invalid move."
    end
    
    it "should print every row of an array" do
      ui.put_message(board.printable_board)
      ui.output.last_message.should == "||||"
    end
  end
  
  it "#ask_for_first_player should return a valid player" do
    ui.ask_for_first_player
    ui.input.last_message.should == "1"
  end
  
  it "allows me to set output" do
    fake = stub
    ui.set_output(fake)
    ui.output.should == fake
  end
end