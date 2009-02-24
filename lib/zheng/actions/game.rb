module Zheng
  module Actions
    module Game
      module_function
      def add lname, rname, winner
        left, right = [ lname, rname ].map { |n| Zheng::Player.named(n) }
        game = Zheng::Game.create :left => left, :right => right, :winner => winner_sym(winner)
        game.apply
      end

      def winner_sym winner
        return :left if winner == "first"
        return :right if winner == "second"
        return winner.to_sym
      end
    end
  end
end
