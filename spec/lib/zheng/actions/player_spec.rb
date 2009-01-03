require File.dirname(__FILE__) + '/../../../spec_helper'

include Zheng

describe Zheng::Actions::Player do
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

  describe "add_external" do
    it "should add a player that is flagged as an external player" do
      p = mock("player")
      Player.should_receive(:create).with(:name => "Peter", :rating => 2100).and_return(p)
      p.should_receive(:set_external!)
      p.should_receive(:save)
      Actions::call "player", "add_external", "Peter", "2100"
    end
  end

  describe "list" do
    before do
      @p1 = mock("a player", :name => "One", :rating => 2000, :rank => '1k')
      @p2 = mock("another player", :name => "Two", :rating => 2200, :rank => '2d')
      Zheng.stub!(:output)
    end
    it "should produce a list of all the players in the database" do
      Player.should_receive(:reverse_order).with(:rating).and_return([@p2, @p1])
      Zheng.should_receive(:output).with("Two                  2d (2200)").exactly(:once) {
        Zheng.should_receive(:output).with("One                  1k (2000)").exactly(:once)
      }
      Actions::call "player", "list"
    end
    it "should not list external players"
    it "should allow a parameter 'all' to list all players, including external"
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