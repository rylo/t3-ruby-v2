require 'spec_helper'

describe Runner do
  let(:runner) { Runner.new }
  
  it "should create a game" do
    pending "not printing out the entire game and giving me errors"
    runner.game.should_not be_nil
  end
end