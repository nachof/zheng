module Zheng
  module Actions
    module Player
      module_function

      def add(name, rank)
        if Zheng::Rating.is_rank? rank
          Zheng::Player.create(:name => name, :rank => rank)
        else
          Zheng::Player.create(:name => name, :rating => rank.to_i)
        end
      end

      def add_external(name, rank)
        p = add(name, rank)
        p.set_external!
        p.save
      end

      def list what="local"
        what_to_list = (what == "all") ? :all : :local
        Zheng::Player.list(what_to_list).each do |p|
          Zheng.output(sprintf "%-20.20s %s (%s)", p.name, p.rank, p.rating)
        end
      end

      def delete name
        Zheng::Player.named(name).destroy
      end

      def set_rating name, rank
        p = Zheng::Player.named(name)
        if Zheng::Rating.is_rank? rank
          p.rank = rank
        else
          p.rating = rank.to_i
        end
        p.save
      end

      def show name
        player = Zheng::Player.named name
        Zheng.output "#{player.name} -- #{player.rank} (#{player.rating})"
        Zheng.output "Games: #{player.games.count}"
        initial_rank = Zheng::Rating.new(player.initial_rating).rank
        Zheng.output "Initial rating: #{initial_rank} (#{player.initial_rating})"
        max_rank = Zheng::Rating.new(player.max_rating).rank
        Zheng.output "Max rating: #{max_rank} (#{player.max_rating})"
      end
    end
  end
end
