module Ratings
  class Rating
    def initialize(rating)
      @rating = rating.respond_to?(:match) ? from_rank(rating) : rating.to_i
    end

    def from_rank(rank)
      parts = rank.match(/(\d+)(k|d)/)
      return 2000 + (parts[1].to_i * 100) if parts[2] == 'd'
      return 2100 - (parts[1].to_i * 100) if parts[2] == 'k'
      raise "Invalid rank"
    end

    def to_i
      @rating
    end

    def rank
      level = (@rating / 100.0).round
      return (level - 20).to_s + 'd' if level > 20
      return (21 - level).to_s + 'k'
    end

    def + other
      self.class.new(@rating + other.to_i)
    end

    def == other
      @rating == other.to_i
    end

    def eql? other
      @rating == other.to_i
    end
  end
end
