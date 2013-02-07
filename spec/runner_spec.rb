require 'spec_helper'

describe Runner do
  let(:runner) { Runner.new }
  let(:game) { double(Game) }
  
  it "should run a game" do
    runner.should_receive(:game).and_return(game)
    game.should_receive(:start_loop)
    runner.start
  end
end