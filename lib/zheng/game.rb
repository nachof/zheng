module Zheng
  class Game < Sequel::Model
    before_create :set_ratings
    before_create :set_date

    set_schema do
      primary_key :id
      foreign_key :left_id, :players
      foreign_key :right_id, :players
      text :winner, :null => false
      float :left_rating_before, :null => false
      float :right_rating_before, :null => false
      date :date, :null => false
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
      expected = Parameters.expected(rating_before(which_player), rating_before(which_opponent))
      return Parameters.Con(rating_before(which_player)) * (result(which_player) - expected)
    end

    def rating_before which_player
      send("#{identify_player(which_player).to_s}_rating_before".to_sym)
    end
    def rating_after which_player
      rating_before(which_player) + rating_change_for(which_player)
    end

    def result which_player
      (which_player == winner) ? 1 : 0
    end

    def apply
      unless left.external?
        left.rating = left.rating + rating_change_for(:left)
        left.save
      end
      unless right.external?
        right.rating = right.rating + rating_change_for(:right)
        right.save
      end
    end

  private

    def set_ratings
      self.left_rating_before = left.rating
      self.right_rating_before = right.rating
    end

    def set_date
      self.date = Date.today if date.nil?
    end

    def identify_player which_player
      return :left if which_player == left
      return :right if which_player == right
      return which_player
    end

  end
end

