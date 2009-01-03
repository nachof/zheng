require File.dirname(__FILE__) + '/../../spec_helper'

include Zheng

describe Zheng::Actions do
  describe "action dispatching" do
    before do
      module Zheng; module Actions
        module Test
          module_function
          def test(param1, param2);end
        end
      end;end
    end

    it "should call the appropriate action" do
      Actions::Test.should_receive(:test).with("one", "two")
      Actions::call "test", "test", "one", "two"
    end
    it "should raise an error if it can't find the action" do
      lambda { Actions::call "something", "anything" }.should raise_error(Actions::NoActionFound)
      lambda { Actions::call "test", "nonexistent" }.should raise_error(Actions::NoActionFound)
    end
    it "should not swallow exceptions that don't mean inexistent methods or actions" do
      Actions::Test.should_receive(:test).any_number_of_times.and_raise(Sequel::DatabaseError)
      lambda { Actions::call "test", "test", "something", "else" }.should_not raise_error(Actions::NoActionFound)
    end
  end

  describe "scripts" do
    it "should execute the line received" do
      Actions.should_receive(:call).with("player", "add", "Peter", "1d")
      Actions::script 'player add Peter 1d'
    end
    it "should correctly parse the quoted spaces" do
      Actions.should_receive(:call).exactly(3).times.with("player", "add", "Lee Sedol", "10d")
      Actions::script 'player add "Lee Sedol" 10d'
      Actions::script 'player add \'Lee Sedol\' 10d'
      Actions::script 'player add Lee\ Sedol 10d'
    end
    it "should ignore leading whitespace" do
      Actions.should_receive(:call).with("player", "add", "Peter", "1d")
      Actions::script '      player add Peter 1d'
    end
    it "should ignore multiple whitespace" do
      Actions.should_receive(:call).with("player", "add", "Peter", "1d")
      Actions::script "player    add\tPeter    1d"
    end
    it "should execute many lines passed" do
      Actions.should_receive(:call).with("player", "add", "Peter", "1d")
      Actions.should_receive(:call).with("player", "add", "John", "1k")
      Actions::script "player add Peter 1d\nplayer add John 1k"
    end
    it "should ignore comments and empty lines" do
      Actions.should_receive(:call).with("player", "add", "Peter", "1d")
      Actions.should_receive(:call).with("player", "add", "John", "1k")
      Actions::script "player add Peter 1d\n#A Comment\n\n   \nplayer add John 1k"
    end
    it "should not stop execution because of an error" do
      lambda { Actions::script "player add Peter 1d\nplayer add Peter 1k" }.should_not raise_error
    end
  end
end
