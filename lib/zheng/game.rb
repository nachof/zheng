module Zheng
  class Game < Sequel::Model
    before_create :set_ratings

    set_schema do
      primary_key :id
      foreign_key :left_id, :players
      foreign_key :right_id, :players
      text :winner, :null => false
      float :left_rating_before, :null => false
      float :right_rating_before, :null => false
    end

    belongs_to :left, :class => :Player
    belongs_to :right, :class => :Player

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

    def rating_before which_player
      send("#{which_player.to_s}_rating_before".to_sym)
    end
    def rating_after which_player
      rating_before(which_player) + rating_change_for(which_player)
    end

    def result which_player
      (which_player == winner) ? 1 : 0
    end

  private

    def set_ratings
      self.left_rating_before = left.rating
      self.right_rating_before = right.rating
    end

  end
end

