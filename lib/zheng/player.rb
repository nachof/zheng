module Zheng
  class Player < Sequel::Model
    set_schema do
      primary_key :id
      text :name, :null => false, :unique => true
      float :rating, :null => false
      boolean :external, :default => false
    end

    include Util

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

    def self.list what=:local
      what_to_order = (what == :all) ? self : filter(:external => false)
      what_to_order.reverse_order(:rating)
    end
  end
end
