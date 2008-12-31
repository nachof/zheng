module Ratings
  module Actions
    module Player
      module_function

      def add(name, rank)
        if is_rank? rank
          Ratings::Player.create(:name => name, :rank => rank)
        else
          Ratings::Player.create(:name => name, :rating => rank.to_i)
        end
      end

      def is_rank? rank
        return false unless rank.respond_to? :match
        return false unless rank.match /\d+(k|d)/
        return true
      end
    end
  end
end
