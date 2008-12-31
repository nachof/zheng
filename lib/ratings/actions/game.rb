module Ratings
  module Actions
    module Game
      module_function
      def add lname, rname, winner
        left, right = [ lname, rname ].map { |n| Ratings::Player.named(n) }
        Ratings::Game.create :left => left, :right => right, :winner => winner_sym(winner)
      end

      def winner_sym winner
        return :left if winner == "first"
        return :right if winner == "second"
        return winner.to_sym
      end
    end
  end
end
