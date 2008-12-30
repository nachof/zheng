module Ratings
  class Rating
    def initialize(rating)
      @rating = rating
    end

    def to_i
      @rating
    end

    def rank
      level = @rating / 100
      return (level - 20).to_s + 'd' if level > 20
      return (21 - level).to_s + 'k'
    end
  end
end
