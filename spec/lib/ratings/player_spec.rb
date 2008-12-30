require File.dirname(__FILE__) + '/../../spec_helper'

include Ratings

describe Ratings::Player do
  describe "instantiation" do
    it "should allow to create with a name and rank" do
      p = Player.new('John Smith', '1d')
      p.name.should == "John Smith"
      p.rank.should == '1d'
    end
  end

  it "should know its rating" do
    p = Player.new('John Smith', '1d')
    p.rating.should == 2100
  end
end
