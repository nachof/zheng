require File.dirname(__FILE__) + '/../../spec_helper'

include Ratings

describe Ratings::Player do
  describe "instantiation" do
    it "should allow to create with a name and rank" do
      pending
      p = Player.new('John Smith', '1d')
      p.name.should == "John Smith"
      p.rank.should == '1d'
    end

    it "should allow to create with a name and rating" do
      p = Player.new(:name => 'John Smith', :rating => 2100)
      p.name.should == "John Smith"
      p.rank.should == '1d'
    end
  end

  describe "saving and retrieving" do
    before do
      @p = Player.new(:name => 'John Smith', :rating => 2100)
      DB[:players].delete
      DB[:players].should have(0).players
    end

    it "should save" do
      @p.save
      DB[:players].should have(1).player
    end

    it "should restore the correct data" do
      @p.save
      p = Player.first
      p.name.should == @p.name
      p.rating.should == @p.rating
    end
  end
end
