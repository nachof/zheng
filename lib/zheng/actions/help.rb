module Zheng
  module Actions
    module Help
      module_function
      def __default
        Zheng.output "Zheng commands have the form [group] [action] [parameters]"
        Zheng.output "Possible groups are:"
        Zheng.output "game"
        Zheng.output "player"
        Zheng.output "database"
        Zheng.output "help"
      end
    end
  end
end
