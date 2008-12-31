require File.dirname(__FILE__) + '/../../spec_helper'

include Ratings

describe Ratings::Game do
  before do
    @left = Player.create(:name => "First Player", :rank => '1d')
    @right = Player.create(:name => "Second Player", :rank => '2k')
  end

  it "should be able to save and restore and all that" do
    game = Game.create(:left => @left, :right => @right, :winner => :left)
    game.left.should == @left
    game.right.should == @right
    game.winner.should == :left
  end
end

