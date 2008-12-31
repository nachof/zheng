require File.dirname(__FILE__) + '/../../../spec_helper'

include Ratings

describe Ratings::Actions::Player do
  describe "add" do
    before do
      @p1 = mock("player1", :name => "Peter", :rating => 2400)
      @p2 = mock("player2", :name => "John", :rating => 2400)
      Player.stub!(:named).and_return @p1, @p2
      Game.stub!(:create)
    end

    it "should add a new game, winner left" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :left)
      Actions::call "game", "add", "Peter", "John", "left"
    end
    it "should add a new game, winner right" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :right)
      Actions::call "game", "add", "Peter", "John", "right"
    end
    it "should add a new game, winner first" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :left)
      Actions::call "game", "add", "Peter", "John", "first"
    end
    it "should add a new game, winner second" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :right)
      Actions::call "game", "add", "Peter", "John", "second"
    end

    it "should change the ratings of the players according to the game"
  end
end
