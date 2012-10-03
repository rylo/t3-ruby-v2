require 'spec_helper'

describe Board do
  let(:ui) { ConsoleUI }
  let(:game) { Game.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE, ConsoleUI) }
  let(:board) { Board.new('3') }
  
  before { ConsoleUI.set_output(MockOutput.new) }
  before { ConsoleUI.set_input(MockInput.new) }
  
  it "should have a size" do
    board.size.should be(3)
  end
  
  describe "#printable_board" do
    it "should print the board" do
      ui.put_message(board.printable_board)
      ui.output.messages.last(3).should == ["||||", "||||", "||||"]
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
  
  describe "#set_move" do  
    it "#set_move places a move on the grid" do
      board.set_move(PLAYER1_MARKER, 3)
      board.grid.should == ["","","",PLAYER1_MARKER,"","","","",""]
    end
    
    it "#set_move won't place a move if the spot is not valid" do
      board.set_move(PLAYER1_MARKER, 3)
      board.set_move(PLAYER2_MARKER, 3)
      board.grid.should == ["","","",PLAYER1_MARKER,"","","","",""]
    end
    
    it "#set_move won't place a move if the game is over" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 2)
      board.grid.should == [PLAYER1_MARKER,PLAYER1_MARKER,PLAYER1_MARKER,"","","","","",""]

      board.set_move(game.player(1).marker, 3)

      board.grid.should == [PLAYER1_MARKER,PLAYER1_MARKER,PLAYER1_MARKER,"","","","","",""]
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
  
  describe "#winning_move_available?(player)" do
    it "returns a grid location for a win" do
      board.set_move(game.player(1).marker, 0)
      board.winning_move_available?(game.player(1).marker).should == false
      
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(2).marker, 4)
      board.winning_move_available?(game.player(1).marker).should == true
      board.winning_move_available?(game.player(2).marker).should == true
    end
  end
  
  describe "#rows_with_open_spaces" do
    it "should give an array with rows with at least one open spot" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(2).marker, 1)
      board.set_move(game.player(1).marker, 3)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(1).marker, 8)
      board.set_move(game.player(2).marker, 7)
      
      board.rows_with_open_spaces.should == [[0, 1, 2], [2, 4, 6], [2, 5, 8], [3, 4, 5], [6, 7, 8], [0, 3, 6]]
    end
  end
  
  describe "#spot_taken?" do
    it "should return false if the spot on the grid is taken" do
      board.spot_taken?(0).should == false
      board.set_move(game.player(1).marker, 0) 
      board.spot_taken?(0).should == true
    end
  end
  
  #
  # NOW PRIVATE METHODS
  #
  # describe "#generate_playable_rows" do
  #   it "should generate playable horizontal rows" do
  #     board.generate_rows[0..2].should eq([[0,1,2], [3,4,5], [6,7,8]])
  #   end
  # 
  #   it "should generate playable diagonal rows" do
  #     board.generate_rows[3..4].should eq([[0,4,8], [2,4,6]])
  #   end
  # 
  #   it "should generate playable vertical rows" do
  #     board.generate_rows[5..7].should eq([[0,3,6], [1,4,7], [2,5,8]])
  #   end
  # end
  #
  
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
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 2)
      
      board.unique_markers([0,1,2]).should == ['x']
      board.unique_markers([0,3,6]).sort.should == ['o', 'x']
    end
  end
  
  describe "open spaces" do
    it "should return an array of empty spaces" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 6)
      board.set_move(game.player(2).marker, 3)
      
      board.open_spaces.should == [2, 4, 5, 7, 8]
    end
  end
  
  describe "#clear_space" do
    it "should replace the grid space with an empty string" do      
      board.set_move(game.player(1).marker, 0)
      
      board.spot_taken?(0).should == true
      board.clear_space(0)
      board.spot_taken?(0).should == false
    end
  end
  
  describe "#winning_moves" do
    it "should return an array of the marker's winning moves" do      
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(2).marker, 3)
      board.winning_moves(game.player(1).marker).should == [2]
      board.winning_moves(game.player(2).marker).should == []
      board.set_move(game.player(1).marker, 6)
      board.set_move(game.player(1).marker, 7)
      board.winning_moves(game.player(1).marker).should == [2,4,8]
    end
  end
  
end


