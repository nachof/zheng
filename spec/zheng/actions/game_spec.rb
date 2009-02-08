require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

include Zheng

describe Zheng::Actions::Player do
  describe "add" do
    before do
      @p1 = mock("player1", :name => "Peter", :rating => 2400)
      @p2 = mock("player2", :name => "John", :rating => 2400)
      [ @p1, @p2 ].each { |p| p.stub! :rating=; p.stub! :save; p.stub!(:external?).and_return(false)}
      @g = mock("game")
      Player.stub!(:named).and_return @p1, @p2
      Game.stub!(:create).and_return @g
      @g.stub!(:rating_change_for).and_return 0
    end

    it "should add a new game, winner left" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :left)
      Actions.call "game", "add", "Peter", "John", "left"
    end
    it "should add a new game, winner right" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :right)
      Actions.call "game", "add", "Peter", "John", "right"
    end
    it "should add a new game, winner first" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :left)
      Actions.call "game", "add", "Peter", "John", "first"
    end
    it "should add a new game, winner second" do
      Game.should_receive(:create).with(:left => @p1, :right => @p2, :winner => :right)
      Actions.call "game", "add", "Peter", "John", "second"
    end

    it "should change the ratings of the players according to the game" do
      @g.should_receive(:rating_change_for).with(:left).and_return -50
      @g.should_receive(:rating_change_for).with(:right).and_return 50
      @p1.should_receive(:rating=).with(2350)
      @p2.should_receive(:rating=).with(2450)
      Actions.call "game", "add", "Peter", "John", "second"
    end

    it "should not change the ratings of players marked as external" do
      @p1.stub!(:external?).and_return(true)
      @g.stub!(:rating_change_for).with(:left).and_return -50
      @g.stub!(:rating_change_for).with(:right).and_return 50
      @p1.should_not_receive(:rating=).with(2350)
      @p2.should_receive(:rating=).with(2450)
      Actions.call "game", "add", "Peter", "John", "second"
    end
  end
end
