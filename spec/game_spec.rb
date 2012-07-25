gem 'rspec'
require 'game'

PLAYER1_MARKER = 'x'
PLAYER2_MARKER = 'o'
BOARD_SIZE = '3'

describe Game do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }

  it "should create two Players" do
    game.player1.marker.should == 'x'
    game.player1.class.should == Player
    
    game.player2.marker.should == 'o'
    game.player2.class.should == Player
  end

  it "should create a Board" do
    game.board.size.should == 3
  end
  
  it "should create an Observer" do
    game.observer.should_not be_nil
  end
  
  it "should start with turn 1" do
    game.current_turn.should eq(1)
  end
  
  it "should generate playable horizontal rows" do
    game.board.generate_playable_rows[0..2].should eq([[0,1,2], [3,4,5], [6,7,8]])
  end
  
  it "should generate playable diagonal rows" do
    game.board.generate_playable_rows[3..4].should eq([[0,4,8], [6,4,2]])
  end
  
  it "should generate playable vertical rows" do
    game.board.generate_playable_rows[5..7].should eq([[0,3,6], [1,4,7], [2,5,8]])
  end
  
  # should increment tests be in Game or Move, since a new Move initiates it?
  
  it "should increment the game's current_turn by one" do
    before_increment = game.current_turn
    game.increment_turn
    game.current_turn.should == before_increment + 1
  end
  
  it "should increment current_turn to 4 after the 3rd move" do
    move = Move.new(game, game.player1.marker, '1')
    move = Move.new(game, game.player2.marker, '2')
    move = Move.new(game, game.player2.marker, '3')
    
    game.current_turn.should eq(4)
  end
  
  it "should return 'someone won' if a row is filled with a player 1's marker" do
    move = Move.new(game, game.player1.marker, '0')
    move = Move.new(game, game.player2.marker, '5')
    move = Move.new(game, game.player1.marker, '1')
    move = Move.new(game, game.player2.marker, '6')
    move = Move.new(game, game.player1.marker, '2')
    
    game.check_for_win.should == 'someone won'
  end
  
  it "should return 'someone won' if a row is filled with a player 2's marker" do
    move = Move.new(game, game.player1.marker, '3')
    move = Move.new(game, game.player2.marker, '1')
    move = Move.new(game, game.player1.marker, '4')
    move = Move.new(game, game.player2.marker, '6')
    move = Move.new(game, game.player1.marker, '5')
    
    game.check_for_win.should == 'someone won'
  end
  
  it "should return 'nobody has won yet' if there are no rows filled with one player's marker" do
    move = Move.new(game, game.player1.marker, '3')
    move = Move.new(game, game.player2.marker, '1')
    move = Move.new(game, game.player1.marker, '4')
    move = Move.new(game, game.player2.marker, '6')
    move = Move.new(game, game.player1.marker, '0')
    move = Move.new(game, game.player2.marker, '2')
    move = Move.new(game, game.player1.marker, '5')
    move = Move.new(game, game.player2.marker, '7')
    move = Move.new(game, game.player1.marker, '8')
    
    game.check_for_win.should == 'nobody has won yet'
  end
end



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



describe Observer do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }

  it "should tell player 1 it is his move" do
    pending "figuring out how to interface with users"
    game.observer.tell(@player1, 'start turn').should == ''
  end
end

