require File.join(File.dirname(__FILE__), '..', 'spec_helper')

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

  describe "listing" do
    before do
      @p1 = Player.create :name => "Peter", :rating => 2000
      @p2 = Player.create :name => "John", :rating => 2100
    end
    it "should return the list of players" do
      list = Player.list
      list.should include(@p1)
      list.should include(@p2)
      list.first.should == @p2
    end
    it "should not list external players" do
      @pe = Player.create :name => "External", :rating => 2100, :external => true
      list = Player.list
      list.should include(@p1)
      list.should include(@p2)
      list.should_not include(@pe)
    end
    it "should list all players if :all passed as a parameter" do
      @pe = Player.create :name => "External", :rating => 2100, :external => true
      list = Player.list :all
      list.should include(@p1)
      list.should include(@p2)
      list.should include(@pe)
    end
  end

  describe "games" do
    before do
      @p = Player.create :name => "Test", :rating => 2100
      @o = Player.create :name => "Opponent", :rating => 2100
      @g = Game.create :left => @p, :right => @o, :winner => :left
    end

    it "should return the player's games" do
      @p.games.should include(@g)
      @o.games.should include(@g)
    end
  end
end
