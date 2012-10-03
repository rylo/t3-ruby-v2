require 'spec_helper'

describe Rules do
  let(:ui) { ConsoleUI }
  let(:game) { Game.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE, ConsoleUI) }
  let(:rules) { Rules.new }
  let(:board) { game.board }
  
  before { ConsoleUI.set_output(MockOutput.new) }
  before { ConsoleUI.set_input(MockInput.new) }
  
  describe "#game_over?" do
    it "should return true if the game is won or a draw" do
      rules.game_over?(board).should == false
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 2)      
      rules.game_over?(board).should == true
    end
  end
  
  describe "#won?" do
    it "should return true if the game is won by any player" do      
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(1).marker, 2)
      
      rules.won?(board).should == true
    end
  end
  
  describe "#draw?" do
    it "should return true if the board is full and there is no winner" do      
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 2)
      board.set_move(game.player(1).marker, 3)
      board.set_move(game.player(1).marker, 7)
      
      board.set_move(game.player(2).marker, 1)
      board.set_move(game.player(2).marker, 4)
      board.set_move(game.player(2).marker, 5)
      board.set_move(game.player(2).marker, 6)
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 8)
      
      rules.draw?(board).should == true
    end
  end
  
  describe "#won_by?(player_marker)" do
    it "should return true if the game is won by the player" do      
      game.board.set_move(game.player(1).marker, 0)
      game.board.set_move(game.player(1).marker, 1)
      rules.won_by?(board, game.player(1).marker).should == false
      
      game.board.set_move(game.player(1).marker, 2)
      rules.won_by?(board, game.player(1).marker).should == true
    end
  end
end