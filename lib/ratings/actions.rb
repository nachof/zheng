module Ratings
  module Actions
    module_function
    def call(mod, action, *params)
      "Actions::#{mod.camelize}".constantize.send(action.to_sym, *params)
    rescue NameError
      raise NoActionFound.new("#{mod} #{action}")
    end

    class NoActionFound < Exception; end
  end

end

require File.dirname(__FILE__) + '/actions/player'
