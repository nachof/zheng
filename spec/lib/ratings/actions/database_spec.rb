require File.dirname(__FILE__) + '/../../../spec_helper'

include Ratings

describe Ratings::Actions::Database do
  describe "clear" do
    it "should delete all players and games" do
      Player.should_receive(:delete).with(no_args)
      Game.should_receive(:delete).with(no_args)
      Actions.call "database", "clear"
    end
  end
end
