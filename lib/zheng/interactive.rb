module Zheng
  module Interactive
    PROMPT = '> '
    module_function
    # Run in interactive mode
    def run
      output "Welcome to Zheng. Type 'help' for... well, for help."
      while true
        line = Readline.readline(PROMPT)
        break if line.nil? or line.strip == 'exit'
        Readline::HISTORY.push(line)
        Actions.script line
      end
      output "\nTerminating"
    end
  end
end
