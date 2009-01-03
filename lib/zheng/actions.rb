module Zheng
  module Actions
    module_function
    def call(mod, action, *params)
      "Actions::#{mod.camelize}".constantize.send(action.to_sym, *params)
    rescue NameError
      raise NoActionFound.new("#{mod} #{action} (#{$!})")
    end

    def script text
      text.each_line do |l|
        begin
          call *Shellwords.shellwords(l) unless l.strip.empty? || l.strip[0,1] == '#'
        rescue
          Zheng::output("An error occured: #{$!}")
        end
      end
    end

    class NoActionFound < Exception; end
  end

end

require File.dirname(__FILE__) + '/actions/player'
require File.dirname(__FILE__) + '/actions/game'
require File.dirname(__FILE__) + '/actions/database'
