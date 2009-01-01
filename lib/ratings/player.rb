module Ratings
  class Player < Sequel::Model
    include Util

    set_dataset :players
    set_primary_key :id

    sequel_accessor :name, :rating

    def rank
      Rating.new(rating).rank
    end
    def rank= rank
      self.rating = Rating.new(rank).to_i
    end

    def self.named name
      raise "Can't find player #{name}" if (found = self[:name => name]).nil?
      found
    end
  end
end
