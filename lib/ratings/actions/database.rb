module Ratings
  module Actions
    module Database
      module_function
      def clear
        Ratings::Player.delete
        Ratings::Game.delete
      end
    end
  end
end
