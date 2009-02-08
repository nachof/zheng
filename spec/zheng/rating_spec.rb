require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Zheng::Rating do
  it "should be initialized from an integer" do
    r = Zheng::Rating.new(2100)
    r.to_i.should == 2100
    r.rank.should == '1d'

    r = Zheng::Rating.new(2000)
    r.to_i.should == 2000
    r.rank.should == '1k'
  end

  it "should be initialized from a rank" do
    r = Zheng::Rating.new('2k')
    r.to_i.should == 1900
    r.rank.should == '2k'

    r = Zheng::Rating.new('2d')
    r.to_i.should == 2200
    r.rank.should == '2d'
  end

  it "should allow to add an integer to it" do
    r = Zheng::Rating.new(2000)
    r = r + 200
    r.to_i.should == 2200
    r.rank.should == '2d'
  end

  it "equality methods" do
    Zheng::Rating.new('1k').should == Zheng::Rating.new(2000)
    Zheng::Rating.new('1k').should eql(Zheng::Rating.new(2000))
    Zheng::Rating.new('1k').should eql(2000)
  end

  it "should give the correct rating for values between steps" do
    equivalences = { 2000 => '1k', 2100 => '1d', 2110 => '1d', 2190 => '2d' }
    equivalences.each do |rating,rank|
      Zheng::Rating.new(rating).rank.should == rank
    end
  end
end
