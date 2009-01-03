module Zheng
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

    def external?
      return @values[:external]
    end
    def set_external!
      @values[:external] = true
    end

    def self.named name
      raise "Can't find player #{name}" if (found = self[:name => name]).nil?
      found
    end

    def self.list
      reverse_order(:rating)
    end
  end
end
