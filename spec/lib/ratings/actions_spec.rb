require File.dirname(__FILE__) + '/../../spec_helper'

include Ratings

describe Ratings::Actions do
  describe "action dispatching" do
    before do
      module Ratings; module Actions
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
end
