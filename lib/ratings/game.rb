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
  end
end

