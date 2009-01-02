module Ratings
  module Actions
    module Player
      module_function

      def add(name, rank)
        if Ratings::Rating.is_rank? rank
          Ratings::Player.create(:name => name, :rank => rank)
        else
          Ratings::Player.create(:name => name, :rating => rank.to_i)
        end
      end

      def add_external(name, rank)
        p = add(name, rank)
        p.set_external!
        p.save
      end

      def list
        Ratings::Player.reverse_order(:rating).each do |p|
          Ratings::output(sprintf "%-20.20s %s (%s)", p.name, p.rank, p.rating)
        end
      end

      def delete name
        Ratings::Player.named(name).destroy
      end

      def set_rating name, rank
        p = Ratings::Player.named(name)
        if Ratings::Rating.is_rank? rank
          p.rank = rank
        else
          p.rating = rank.to_i
        end
        p.save
      end
    end
  end
end
