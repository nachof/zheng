module Ratings
  module Actions
    module Player
      module_function
      def add(name, rank)
        if rank.respond_to? :match
          Ratings::Player.create(:name => name, :rank => rank)
        else
          Ratings::Player.create(:name => name, :rating => rank)
        end
      end
    end
  end
end
