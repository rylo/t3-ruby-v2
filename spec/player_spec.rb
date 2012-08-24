require 'spec_helper'

describe Player do
  let(:gamefactory) { GameFactory.new(PLAYER1_MARKER, HumanPlayer, PLAYER2_MARKER, EasyComputer, BOARD_SIZE) }
  let(:game)        { gamefactory.get_game }
  let(:board)       { game.board }
    
  before { Console.set_output(MockOutput.new) }
  before { Console.set_input(MockInput.new) }
  
  it "should have a marker" do
    game.player(1).marker.should == PLAYER1_MARKER
  end
end

describe EasyComputer do
  let(:gamefactory) { GameFactory.new(PLAYER1_MARKER, EasyComputer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE) }
  let(:game)        { gamefactory.get_game }
  let(:board)       { game.board }
  
  before { Console.set_output(MockOutput.new) }
  
  it "should be a subclass of Player" do
    game.player(1).class.superclass.should == Player
    game.player(1).class.should == EasyComputer
  end
  
  # add get move stuff testing here
  
  it "#get_move should return a valid space" do
    destination = game.player(1).get_move(board)
    board.valid_move?(destination).should == false
  end
end

describe UltimateComputer do
  let(:gamefactory) { GameFactory.new(PLAYER1_MARKER, UltimateComputer, PLAYER2_MARKER, HumanPlayer, BOARD_SIZE) }
  let(:game)        { gamefactory.get_game }
  let(:board)       { game.board }
  
  before { Console.set_output(MockOutput.new) }
  
  it "should be a subclass of Player" do
    game.player(1).class.superclass.should == Player
    game.player(1).class.should == HardComputer
  end
  
  it "#get_move should return a valid space" do
    destination = game.player(1).get_move(board)
    board.valid_move?(destination).should == false
  end
  
  describe "#minimax" do
    it "should make an uber AI that puts GlaDoS to shame (at tic-tac-toe)" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(2).marker, 1)
      board.set_move(game.player(1).marker, 8)
      board.set_move(game.player(2).marker, 2)
      
      game.player(1).find_best_move(board).should == 4
    end
  end
  
  describe "#get_score" do
    it "should return a score based on whether or not player can make a game-ending move" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(2).marker, 3)
      
      game.player(1).get_score(board, game.player(1).marker).should == 4
    end
    
    it "should return a score based on whether or not player can make a game-ending move" do
      board.set_move(game.player(1).marker, 0)
      board.set_move(game.player(1).marker, 1)
      board.set_move(game.player(2).marker, 3)
      
      game.player(1).get_score(board, game.player(1).marker).should == 4
    end
  end
  
  describe "#get_other_player" do
    it "should return the other marker" do      
      game.player(1).get_other_player(game.player(1).marker).should == 'o'
    end
  end
  
end

