module Ratings
  class Player < Sequel::Model
    def name
      @values[:name]
    end
    def rating
      @values[:rating]
    end
    def rank
      Rating.new(rating).rank
    end
  end
end
