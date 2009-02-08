require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper')

include Zheng

describe Zheng::Actions::Database do
  describe "clear" do
    it "should delete all players and games" do
      Player.should_receive(:delete).with(no_args)
      Game.should_receive(:delete).with(no_args)
      Actions.call "database", "clear"
    end
  end
end
