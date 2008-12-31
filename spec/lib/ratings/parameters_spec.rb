require File.dirname(__FILE__) + '/../../spec_helper'

include Ratings

describe Ratings::Parameters do
  describe "parameter e" do
    it "should be 0.014" do
      Parameters::E.should == 0.014
    end
  end
  describe "parameter a" do
    it "should be 200 for rating 100" do
      Parameters::A(100).should == 200
    end
    it "should be 70 for rating 2700" do
      Parameters::A(2700).should == 70
    end
    it "should be 100 for rating 2100" do
      Parameters::A(2100).should == 100
    end
    it "should be 70 for rating 3000" do
      Parameters::A(3000).should == 70
    end
  end

  describe "parameter con" do
    correspondences = { 100=>116, 200=>110, 300=>105, 400=>100, 500=>95, 600=>90, 700=>85, 800=>80, 900=>75, 1000=>70, 1100=>65, 1200=>60, 1300=>55, 1400=>51, 1500=>47, 1600=>43, 1700=>39, 1800=>35, 1900=>31, 2000=>27, 2100=>24, 2200=>21, 2300=>18, 2400=>15, 2500=>13, 2600=>11, 2700=>10, 2800 => 10 }
    correspondences.each do |rating,con|
      it "should be #{con} for rating #{rating}" do
        Parameters::Con(rating).should == con
      end
    end
  end

  describe "expected result" do
    it "should be 0.5 for same rating" do
      Parameters::expected(2000,2000).should == 0.5
      Parameters::expected(200,200).should == 0.5
    end
    it "should be 0.248 for 2300, 2400" do
      Parameters::expected(2300,2400).should be_close(0.248, 0.0005)
    end
    it "should be 0.396 for 320, 400" do
      Parameters::expected(320, 400).should be_close(0.396, 0.0005)
    end
    it "should be (0.604 - e) for 400, 320" do
      Parameters::expected(400, 320).should be_close(0.604 - Parameters::E, 0.0005)
    end
    it "should be (0.752 - e) for 2400, 2300" do
      Parameters::expected(2400, 2300).should be_close(0.752 - Parameters::E, 0.0005)
    end
  end
end
