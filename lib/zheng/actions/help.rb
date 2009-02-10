module Zheng
  module Actions
    module Help
      module_function
      def __default
        Zheng.output "Zheng commands have the form [group] [action] [parameters]"
        Zheng.output "Possible groups are:"
        Zheng.output "game"
        Zheng.output "player"
        Zheng.output "database"
        Zheng.output "help"
      end

      def database
        output "Manipulate the database"
        output ""
        output "database clear"
        output "   Clear all data in the database"
      end

      def game
        output "Manipulate games"
        output ""
        output "game add player1 player2 winner"
        output "   Add a game between player1 and player2, won by the winner specified"
        output "   Winner can be 'left' or 'right', or 'first' or 'second'"
        output "   Example: game add \"Cho Chikun\" \"Takemiya Masaki\" first"
      end

      def player
        output "Manipulate players"
        output ""
        output "player add name level"
        output "   Adds a player with the specified starting level"
        output "   Level can be a ranking or a rating value"
        output "   Example: player add \"John Doe\" 1k"
        output "player add_external name level"
        output "   Like add but adds an external player"
        output "   External players serve as anchors, and their rating does not vary normally"
        output "player list"
        output "   Produce a list of all the non external players"
        output "player list all"
        output "   Produce a list of all the players, including external players"
        output "player set_rating name level"
        output "   Sets the rating of the player to the specified rating or rank"
        output "   Level can be a ranking or rating value"
        output "   Example: player set_rating \"John Doe\" 2d"
        output "player show name"
        output "   Show information about a player"
      end
    end
  end
end
