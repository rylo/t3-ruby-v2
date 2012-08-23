require 'config'

describe Move do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:move) { Move.new(game, game.player1.marker, '3') }

  it "should have a destination" do
    move.destination.should eq(3)
  end
  
  it "should have a player_marker" do
    move.player_marker.should eq(game.player1.marker)
  end
  
  it "shouldn't have a taken destination" do
    move1 = Move.new(game, game.player1.marker, '1')
    expect { move2 = Move.new(game, game.player1.marker, '1') }.to raise_error
  end
  
  it "should make a change to the grid data" do
    game.board.grid[move.destination.to_i].should be_true
  end
  
  it "should place a player's marker on the destination square" do
    game.board.grid[move.destination.to_i].should eq('x')
  end
end