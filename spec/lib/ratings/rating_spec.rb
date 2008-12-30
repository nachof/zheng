require File.dirname(__FILE__) + '/../../spec_helper'

describe Ratings::Rating do
  it "should be initialized from an integer" do
    r = Ratings::Rating.new(2100)
    r.to_i.should == 2100
    r.rank.should == '1d'

    r = Ratings::Rating.new(2000)
    r.to_i.should == 2000
    r.rank.should == '1k'
  end

  it "should be initialized from a rank" do
    r = Ratings::Rating.new('2k')
    r.to_i.should == 1900
    r.rank.should == '2k'

    r = Ratings::Rating.new('2d')
    r.to_i.should == 2200
    r.rank.should == '2d'
  end

  it "should allow to add an integer to it" do
    r = Ratings::Rating.new(2000)
    r = r + 200
    r.to_i.should == 2200
    r.rank.should == '2d'
  end

  it "equality methods" do
    Ratings::Rating.new('1k').should == Ratings::Rating.new(2000)
    Ratings::Rating.new('1k').should eql(Ratings::Rating.new(2000))
    Ratings::Rating.new('1k').should eql(2000)
  end

  it "should give the correct rating for values between steps"
end
