require 'spec_helper'

describe Game do
  let(:game) { Game.new(PLAYER1_MARKER, PLAYER2_MARKER, BOARD_SIZE) }
  let(:board) { game.board }
  
  before { Console.set_output(MockOutput.new) }

  it "returns a player object" do
    game.player(1).marker.should == PLAYER1_MARKER
  end

  it "creates two players" do
    game.generate_players(PLAYER1_MARKER, PLAYER2_MARKER)
    game.player(1).marker.should == PLAYER1_MARKER
    game.player(2).marker.should == PLAYER2_MARKER
  end

  it "creates a board with a size" do
    game.generate_board(3)
    game.board.size.should == BOARD_SIZE
  end
  
  it "starts with turn 1" do
    game.current_turn.should eq(1)
  end
  
  it "increments the game's current_turn by one" do
    turn_before_increment = game.current_turn
    game.increment_turn
    game.current_turn.should == turn_before_increment + 1
  end
  
  it "sets an end_condition if the current_turn = the number of possible spaces" do
    board.grid.count.times { game.increment_turn }
    game.end_condition.should == "Draw!"
  end
  
  describe "#generate_playable_rows" do
    it "should generate playable horizontal rows" do
      board.generate_playable_rows[0..2].should eq([[0,1,2], [3,4,5], [6,7,8]])
    end
  
    it "should generate playable diagonal rows" do
      board.generate_playable_rows[3..4].should eq([[0,4,8], [2,4,6]])
    end
  
    it "should generate playable vertical rows" do
      board.generate_playable_rows[5..7].should eq([[0,3,6], [1,4,7], [2,5,8]])
    end
  end
  
  describe "#check_for_win" do
    it "#check_for_win return true if a row is filled with player 1's marker" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 2)
    
      game.check_for_win.should == [0,1,2]
    end
  
    it "#check_for_win returns the winning row if a row is filled with player 2's marker" do
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(2).marker, 5)
      
      game.check_for_win.should == [3,4,5]
    end
    
    it "sets the games @end_condition when a player wins on a middle horizontal" do
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(2).marker, 5)
      game.check_for_win
      
      game.end_condition.should == "Player #{PLAYER2_MARKER} wins!"
    end
    
    it "sets the games @end_condition when a player wins on a left-right diagonal" do
      board.set_move(game.player(2).marker, 2)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(2).marker, 6)
      game.check_for_win
          
      game.end_condition.should == "Player #{PLAYER2_MARKER} wins!"
    end
    
    it "sets the games @end_condition when a player wins on a right-left diagonal" do
      board.set_move(game.player(2).marker, 0)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(2).marker, 8)
      game.check_for_win
      
      game.end_condition.should == "Player #{PLAYER2_MARKER} wins!"
    end
  end
  
  it "should have a current_player with player1's marker" do
    game.current_player.marker.should == PLAYER1_MARKER
  end
  
  it "should have a current_player that changes after the first turn" do
    board.set_move(game.player(1).marker, 3)
    game.set_current_player
    game.current_player.marker.should == PLAYER2_MARKER
  end
  
  it "changes the current_player after the second turn" do    
    board.set_move(game.player(1).marker, 3)
    board.set_move(game.player(2).marker, 2)
    game.current_player.marker.should == PLAYER1_MARKER
  end
  
  it "sets an end_condition" do
    game.set_end_condition('Player 1 wins').should == 'Player 1 wins'
  end
  
  describe "game loop behavior" do
    it "stops the loop when the @current_turn is greater than the number of playable spaces (board.grid.count)" do
      9.times { game.increment_turn }
      game.end_condition.should == "Draw!"
    end
    
    it "stops the loop at the first turn when the @end_condition is set" do
      game.set_end_condition("Player 1 wins")
      game.current_turn.should == 1
    end
  end
end
