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

