require 'spec_helper'

describe Game do
  let(:console) { ConsoleUI }
  let(:game) { Game.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE, ConsoleUI) }
  let(:board) { game.board }
  
  before { ConsoleUI.set_output(MockOutput.new) }
  before { ConsoleUI.set_input(MockInput.new) }

  describe "#initialize" do
    it "returns a player object" do
      game.player(1).marker.should == PLAYER1_MARKER
    end

    it "creates two players with markers" do
      game.player(1).marker.should == PLAYER1_MARKER
      game.player(2).marker.should == PLAYER2_MARKER
    end
  
    it "creates two human players" do
      game.player(1).class.should == HumanPlayer
      game.player(2).class.should == HumanPlayer
    end
    
    it "creates a human and computer player" do
      game = Game.new(PLAYER1_MARKER, EasyComputer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE, ConsoleUI)
    
      game.player(1).class.should == EasyComputer
      game.player(2).class.should == HumanPlayer
    end

    it "creates a board with a size" do
      game.generate_board(3)
      game.board.size.should == BOARD_SIZE
    end
    
    it "should have a current_player with player1's marker" do
      game.set_first_player
      game.current_player.marker.should == PLAYER1_MARKER
    end
  end
  
  describe "#generate_playable_rows" do
    it "should generate playable horizontal rows" do
      board.generate_rows[0..2].should eq([[0,1,2], [3,4,5], [6,7,8]])
    end
  
    it "should generate playable diagonal rows" do
      board.generate_rows[3..4].should eq([[0,4,8], [2,4,6]])
    end
  
    it "should generate playable vertical rows" do
      board.generate_rows[5..7].should eq([[0,3,6], [1,4,7], [2,5,8]])
    end
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
  
  describe "game loop behavior" do
    it "stops the loop when the game is won" do
      board.set_move(game.player(2).marker, 0)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(2).marker, 8)
      
      game.report_end_state.should == "Player #{PLAYER2_MARKER} wins!"
    end
    
    it "stops the loop when the game is a draw" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(2).marker, 1)
      board.set_move(game.player(1).marker, 2)
      board.set_move(game.player(2).marker, 3)
      board.set_move(game.player(1).marker, 4)
      board.set_move(game.player(1).marker, 5)
      board.set_move(game.player(2).marker, 6)
      board.set_move(game.player(1).marker, 7)
      board.set_move(game.player(2).marker, 8)
      
      game.report_end_state.should == "Draw!"
    end
  end
  
  describe "#report_end_state" do
    it "should return the ending state of the game" do
      board.set_move(game.player(2).marker, 0)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(2).marker, 8)
      
      game.report_end_state.should == "Player #{PLAYER2_MARKER} wins!"
    end
  end
  
  describe "#set_ui" do
    it "should set the ui for the game" do
      game.set_ui(ConsoleUI)
      game.ui.should == ConsoleUI
    end
  end

end
