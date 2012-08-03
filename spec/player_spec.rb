require 'spec_helper'

describe Player do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:player) { Player.new(PLAYER1_MARKER) }
  
  it "should have a marker" do
    player.marker.should == PLAYER1_MARKER
  end
end