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

  it "should be initialized from a rank"
  it "should allow to add an integer to it"
end
