module Ratings
  class Player < Sequel::Model
    set_dataset :players
    set_primary_key :id

    def name
      @values[:name]
    end
    def rating
      @values[:rating]
    end
    def rating= v
      @values[:rating] = v
    end
    def rank
      Rating.new(rating).rank
    end
    def rank= rank
      self.rating = Rating.new(rank).to_i
    end
  end
end
