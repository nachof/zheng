module Ratings
  class Game < Sequel::Model
    set_dataset :games
    set_primary_key :id
    belongs_to :left, :class => :Player
    belongs_to :right, :class => :Player

    def right_id
      @values[:right_id]
    end
    def right_id= v
      @values[:right_id] = v
    end
    def left_id
      @values[:left_id]
    end
    def left_id= v
      @values[:left_id] = v
    end
    def winner
      @values[:winner].to_sym
    end
    def winner= v
      @values[:winner] = v.to_s
    end
  end
end

