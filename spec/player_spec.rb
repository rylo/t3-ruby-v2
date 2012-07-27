require 'spec_config'

describe Player do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  
  it "should have a marker" do
    p = Player.new(PLAYER1_MARKER)
    p.marker.should be(PLAYER1_MARKER)
  end
end