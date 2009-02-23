require File.join(File.dirname(__FILE__), '..', 'spec_helper')

include Zheng

describe Zheng::Game do
  before do
    Player.delete
    @left = Player.create(:name => "First Player", :rank => '1d')
    @right = Player.create(:name => "Second Player", :rank => '2k')
  end

  it "should be able to save and restore and all that" do
    game = Game.create(:left => @left, :right => @right, :winner => :left)
    game.left.should == @left
    game.right.should == @right
    game.winner.should == :left
  end

  it "should tell the players' previous rating" do
    game = Game.create(:left => @left, :right => @right, :winner => :left)
    game.rating_before(:left).should == 2100
    game.rating_before(:right).should == 1900
  end

  it "should tell the players' rating after" do
    game = Game.create(:left => @left, :right => @right, :winner => :left)
    game.rating_after(:left).should == (game.rating_before(:left) + game.rating_change_for(:left))
    game.rating_after(:right).should == (game.rating_before(:right) + game.rating_change_for(:right))
  end

  it "should store the date the game was added" do
    game = Game.create(:left => @left, :right => @right, :winner => :left)
    game.date.should == Date.today
  end

  it "should store the date specified" do
    date = Date.new(2008, 1, 1)
    game = Game.create(:left => @left, :right => @right, :winner => :left, :date => date)
    game.date.should == date
  end

  describe "ratings calculations" do
    before do
      @game = Game.create(:left => @left, :right => @right, :winner => :left)
    end

    it "should calculate a positive rating change for the winner" do
      @game.rating_change_for(:left).should > 0
    end

    it "should calculate a negative rating change for the loser" do
      @game.rating_change_for(:right).should < 0
    end

    it "should calculate the same rating change after changing the players' ratings (that is, use the values they had before)" do
      change_left = @game.rating_change_for(:left)
      @left.rank = '1k'
      @left.save
      @right.rank = '1k'
      @right.save
      @game.reload
      @game.rating_change_for(:left).should == change_left
    end

    describe "for same rating" do
      describe "(2400)" do
        before do
          left = Player.create(:name => "left", :rating => 2400)
          right = Player.create(:name => "right", :rating => 2400)
          @game = Game.create(:left => left, :right => right, :winner => :left)
        end

        it "should calculate the correct rating change for the loser" do
          @game.rating_change_for(:right).should == -7.5
        end
        it "should calculate the correct rating change for the winner" do
          @game.rating_change_for(:left).should == 7.5
        end
      end
      describe "(500)" do
        before do
          left = Player.create(:name => "left", :rating => 500)
          right = Player.create(:name => "right", :rating => 500)
          @game = Game.create(:left => left, :right => right, :winner => :left)
        end

        it "should calculate the correct rating change for the loser" do
          @game.rating_change_for(:right).should == -47.5
        end
        it "should calculate the correct rating change for the winner" do
          @game.rating_change_for(:left).should == 47.5
        end
      end
    end

    describe "for ratings 320, 400" do
      before do
        left = Player.create(:name => "left", :rating => 400)
        right = Player.create(:name => "right", :rating => 320)
        @game = Game.create(:left => left, :right => right, :winner => :right)
      end

      it "should calculate the correct rating change for the loser" do
        @game.rating_change_for(:left).should be_close(-60, 1)
      end
      it "should calculate the correct rating change for the winner" do
        @game.rating_change_for(:right).should be_close(63, 1)
      end
    end

  end
end

