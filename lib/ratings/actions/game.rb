module Ratings
  module Actions
    module Game
      module_function
      def add lname, rname, winner
        left, right = [ lname, rname ].map { |n| Ratings::Player.named(n) }
        game = Ratings::Game.create :left => left, :right => right, :winner => winner_sym(winner)
        left.rating = left.rating + game.rating_change_for(:left)
        left.save
        right.rating = right.rating + game.rating_change_for(:right)
        right.save
      end

      def winner_sym winner
        return :left if winner == "first"
        return :right if winner == "second"
        return winner.to_sym
      end
    end
  end
end
