require 'spec_config'

describe Console do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:board) { game.board }
  
  it "accepts input" do
    Console.input.should_not be_nil
  end
  
  it "accepts a valid move" do
    pending 'ability to ask for a move'
  end
end