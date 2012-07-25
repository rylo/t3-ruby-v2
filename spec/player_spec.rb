require 'config'

describe Player do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  
  it "should have a marker" do
    marker = 'x'
    p = Player.new(marker)
    p.marker.should be(marker)
  end
  
  it "should make a new move" do
    player_marker = 'x'
    destination = 1
    move = Move.new(game, player_marker, destination)
    game.should be(game)
    move.player_marker.should eq(player_marker)
    move.destination.should eq(destination)
  end
end