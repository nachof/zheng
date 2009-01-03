module Zheng
  module Actions
    module Database
      module_function
      def clear
        Zheng::Player.delete
        Zheng::Game.delete
      end
    end
  end
end
