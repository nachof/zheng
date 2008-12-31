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
    it "should add a new player with rating as string"
  end
end
