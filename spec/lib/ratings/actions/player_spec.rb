require File.dirname(__FILE__) + '/../../../spec_helper'

include Ratings

describe Ratings::Actions::Player do
  describe "add" do
    it "should add a new player with rank" do
      Player.should_receive(:create).with(:name => "Peter", :rank => "7d")
      Actions::call "player", "add", "Peter", "7d"
    end
    it "should add a new player with rating" do
      Player.should_receive(:create).with(:name => "Peter", :rating => 2100)
      Actions::call "player", "add", "Peter", 2100
    end
    it "should add a new player with rating as string" do
      Player.should_receive(:create).with(:name => "Peter", :rating => 2100)
      Actions::call "player", "add", "Peter", "2100"
    end
  end

  describe "list" do
    before do
      @p1 = mock("a player", :name => "One", :rating => 2000, :rank => '1k')
      @p2 = mock("another player", :name => "Two", :rating => 2200, :rank => '2d')
      Ratings.stub!(:output)
    end
    it "should produce a list of all the players in the database" do
      Player.should_receive(:reverse_order).with(:rating).and_return([@p2, @p1])
      Ratings.should_receive(:output).with("Two                  2d (2200)").exactly(:once) {
        Ratings.should_receive(:output).with("One                  1k (2000)").exactly(:once)
      }
      Actions::call "player", "list"
    end
  end

  describe "delete" do
    before do
      @p = mock("player")
      Player.stub!(:named).and_return(@p)
    end
    it "should delete a player" do
      Player.should_receive(:named).with("Peter").and_return(@p)
      @p.should_receive(:destroy)
      Actions::call "player", "delete", "Peter"
    end
  end

  describe "set_rating" do
    before do
      @p = mock("player")
      @p.stub! :save
      Player.stub!(:named).and_return(@p)
    end
    it "should allow to reset a player's rating" do
      Player.should_receive(:named).with("Peter").twice.and_return(@p)
      @p.should_receive(:rank=).with('2k')
      Actions::call "player", "set_rating", "Peter", "2k"
      @p.should_receive(:rating=).with(2000)
      Actions::call "player", "set_rating", "Peter", "2000"
    end
  end
end
