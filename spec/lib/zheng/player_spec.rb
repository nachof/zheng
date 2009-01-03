require File.dirname(__FILE__) + '/../../spec_helper'

include Zheng

describe Zheng::Player do
  before do
    Player.delete
    @p = Player.new(:name => 'John Smith', :rating => 2100)
  end

  it "should allow to set the rank" do
    @p.rank = '4d'
    @p.rating.should == 2400
  end

  it "should have an unique name" do
    p = Player.create(:name => "Unique", :rank => '2d')
    lambda { p = Player.create(:name => "Unique", :rank => '2d') }.should raise_error
  end

  describe "instantiation" do
    it "should allow to create with a name and rank" do
      p = Player.new(:name => 'John Smith', :rank => 2100)
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
      Player.delete
      Player.should have(0).players
    end

    it "should save" do
      @p.save
      Player.should have(1).player
    end

    it "should restore the correct data" do
      @p.save
      p = Player.first
      p.name.should == @p.name
      p.rating.should == @p.rating
    end

    it "should save and restore when setting rank" do
      p = Player.create(:name => 'John Smith', :rank => '4d')
      p.rank.should == '4d'
      p.rating.should == 2400
      p.rank = '2d'
      p.save
      pp = Player[p.pk]
      pp.rating.should == 2200
      pp.rank.should == '2d'
    end
  end

  describe "external players" do
    it "should be possible to set a player's flag to external" do
      @p.should_not be_external
      @p.set_external!
      @p.should be_external
      @p.save
      Player[@p.pk].should be_external
    end
  end

  describe "finding" do
    before do
      Player.create :name => "Peter", :rating => 2000
    end

    it "should be possible to find a player by name" do
      Player.named("Peter").name.should == "Peter"
      Player.named("Peter").rating.should == 2000
    end

    it "should raise an error if the named player does not exist" do
      lambda { Player.named("I do not exist") }.should raise_error
    end
  end
end
