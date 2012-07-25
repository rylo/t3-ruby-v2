require 'spec_config'

describe Runner do
  let(:runner) { Runner.new }
  
  it "should create a game" do
    runner.game.should_not be_nil
  end
end