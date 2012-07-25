require 'config'

describe Board do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:board) { Board.new('3') }
  
  it "should have a size" do
    board.size.should be(3)
  end

  it "should have a grid (array to contain data)" do
    board.grid.should_not be_nil
  end
  
  it "should have an array of left/right winnable rows" do
    board.rows.should_not eq([])
  end
  
  it "should have a square grid" do
    board.grid.count.should be(board.size.to_i**2)
  end
end
