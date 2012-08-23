require 'spec_helper'

describe Board do
  let(:console) { Console }
  let(:game) { Game.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE) }
  let(:board) { Board.new('3') }
  
  before { Console.set_output(MockOutput.new) }
  before { Console.set_input(MockInput.new) }
  
  it "should have a size" do
    board.size.should be(3)
  end
  
  describe "#print_board" do
    it "should print the board" do
      board.print_board
      console.output.messages.last(3).should == ["||||", "||||", "||||"]
    end
  end
  
  describe '#valid_move?' do
    it "should return false when a user's move is not a valid spot on the board" do
      destination = 'x'
      board.valid_move?(destination).should == false
    end
  
    it "should return false when a user's destination is already taken" do
      board.set_move(PLAYER1_MARKER, 0)
      destination = '0'
      board.valid_move?(destination).should == false
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
  
  describe "#ending_move_available?" do
    it "returns true if an ending move exists" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(2).marker, 4)

      board.ending_move_available?.should == true
    end
  end
  
  describe "#ending_move_rows" do
    it "returns an array of rows with one empty spot and with all others filled by one type of player marker" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(2).marker, 4)

      board.ending_move_rows.should == [[0,1,2],[3,4,5]]
    end
  end
  
  describe "#select_ending_move(player)" do
    it "returns a grid location for a win" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(2).marker, 4)

      board.select_ending_move(game.player(1)).should == 2
    end
    
    it "returns a grid location to stop an opponent's win" do
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(2).marker, 4)

      board.select_ending_move(game.player(1)).should == 5
    end
  end
  
  describe "#playable_rows" do
    it "should give an array with rows with at least one open spot" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 3)
      board.set_move(game.player(1).marker, 4)
      board.set_move(game.player(1).marker, 8)
      board.set_move(game.player(1).marker, 7)
      
      board.playable_rows.should == [[0, 1, 2], [2, 4, 6], [2, 5, 8], [3, 4, 5], [6, 7, 8], [0, 3, 6]]
    end
  end
  
  describe "#spot_taken?" do
    it "should return false if the spot on the grid is taken" do
      board.set_move(game.player(1).marker, 0) 
      board.spot_taken?(0).should == true
    end
  end
  
  describe "#view_row_markers" do
    it "should return the row with grid markers filled in" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 2)
      
      board.view_row_markers([0,1,2]).should == [game.player(1).marker, game.player(1).marker, game.player(1).marker]
      board.view_row_markers([0,3,6]).should == [game.player(1).marker,"",""]
      board.view_row_markers([3,4,5]).should == ["","",""]
    end
  end
  
  describe "#unique_row_markers" do
    it "should return an array of unique, non-blank markers in the row" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 2)
      board.set_move(game.player(2).marker, 3)
      
      board.unique_markers([0,1,2]).should == ['x']
      board.unique_markers([0,3,6]).sort.should == ['o', 'x']
    end
  end
end


