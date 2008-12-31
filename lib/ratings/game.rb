module Ratings
  class Game < Sequel::Model
    include Util

    set_dataset :games
    set_primary_key :id
    belongs_to :left, :class => :Player
    belongs_to :right, :class => :Player

    sequel_accessor :right_id, :left_id

    def winner
      @values[:winner].to_sym
    end
    def winner= v
      @values[:winner] = v.to_s
    end

    def rating_change_for which_player
      which_opponent = (which_player == :left) ? :right : :left
      player, opponent = [which_player, which_opponent].map { |p| send(p) }
      return Parameters::Con(player.rating) * (result(which_player) - Parameters::expected(player.rating, opponent.rating))
    end

    def result which_player
      (which_player == winner) ? 1 : 0
    end
  end
end

