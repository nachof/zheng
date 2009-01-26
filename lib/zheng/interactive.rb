module Zheng
  module Interactive
    PROMPT = '> '
    module_function
    # Run in interactive mode
    def run
      while true
        print PROMPT
        line = gets
        break if line.nil? or line.strip == 'exit'
        Actions.script line
      end
      puts "\nTerminating"
    end
  end
end
