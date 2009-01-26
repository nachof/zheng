module Zheng
  module Interactive
    PROMPT = '> '
    module_function
    # Run in interactive mode
    def run
      while true
        line = Readline::readline(PROMPT)
        break if line.nil? or line.strip == 'exit'
        Readline::HISTORY.push(line)
        Actions.script line
      end
      puts "\nTerminating"
    end
  end
end
