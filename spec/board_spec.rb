require 'spec_helper'

describe Board do
  let(:console) { Console }
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:board) { Board.new('3') }
  
  before { Console.set_output(MockOutput.new) }
  
  it "should have a size" do
    board.size.should be(3)
  end
  
  describe "#print_board" do
    it "should print the board" do
      board.print_board
      console.output.messages.last(3).should == ["||||", "||||", "||||"]
    end
  end
  
  describe '#validate_move' do
    it "should return 'invalid' when a user's move is not a valid spot on the board" do
      destination = 'x'
      board.validate_move(destination).should == "invalid"
    end
  
    it "should return 'invalid' when a user's destination is already taken" do
      board.set_move(PLAYER1_MARKER, 0)
      destination = '0'
      board.validate_move(destination).should == "invalid"
    end
  end
  
  it "should have a grid (array to contain data)" do
    board.grid.should_not be_nil
  end
  
  it "should have an array of left/right winnable rows" do
    board.rows[0..(BOARD_SIZE-1)].should == [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
  end
  
  it "should have an array of diagonal winnable rows" do
    board.rows[(BOARD_SIZE)..(BOARD_SIZE+1)].should == [[0, 4, 8], [2, 4, 6]]
  end
  
  it "should have a square grid" do
    board.grid.count.should be(board.size.to_i**2)
  end
  
  describe "#set_move and #fetch_grid" do  
    it "#fetch_grid returns the grid and #set_move places a move on the grid" do
      board.fetch_grid.should == ["","","","","","","","",""]
      board.set_move(PLAYER1_MARKER, 3)
      board.fetch_grid.should == ["","","",PLAYER1_MARKER,"","","","",""]
    end
  end
end