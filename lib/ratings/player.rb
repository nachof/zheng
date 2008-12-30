module Ratings
  class Player
    attr_accessor :name

    def initialize(name, rank)
      @name = name
      @rating = Rating.new(rank)
    end

    def rating
      @rating.to_i
    end

    def rank
      @rating.rank
    end

  end
end
