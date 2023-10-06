# frozen_string_literal: true

require_relative '../modules/util'

module QuakeLogs
  module Business
    # Killers
    # Contains all rules about kills
    class Killers
      attr_accessor :array_log, :util

      def initialize(array_log)
        @array_log = array_log
        @util = QuakeLogs::Modules::Util.new(array_log)
      end

      def kills_by_game
        kills_all_by_game.map do |kills|
          kills.map do |kill|
            killed = array_log[kill].split(/(\s\d+\s\d+\s\d+)/)[1].split(/\s/).compact
            verify_killed(killed)
          end
        end
      end

      def kills_by_game_and_means
        kills_by_game.map do |kills|
          all_means = build_kill_by_means(kills)
          means = all_means.select { |mean| mean unless mean.nil? }
          means.sort { |mean1, mean2| mean2.last <=> mean1.last }
        end
      end

      def count_killed_by_player(kills, player_id)
        kills.count { |kill| kill[:player1] == player_id }
      end

      def count_world_killed_by_player(kills, player_id)
        kills.count { |kill| kill[:player1] == 1022 && kill[:player2] == player_id }
      end

      def count_all_killed_by_game(kills)
        kills.count { |kill| kill[:player1].positive? }
      end

      def count_kills_by_means(kills, mean)
        kills.count { |kill| kill[:weapon] == mean }
      end

      private

      def build_kill_by_means(kills)
        build_means.map do |mean|
          count_killed_mean = count_kills_by_means(kills, mean.last)
          [mean.first, count_killed_mean] if count_killed_mean.positive?
        end
      end

      def build_means
        [['MOD_UNKNOWN', 0], ['MOD_SHOTGUN', 1], ['MOD_GAUNTLET', 2], ['MOD_MACHINEGUN', 3], ['MOD_GRENADE', 4],
         ['MOD_GRENADE_SPLASH', 5], ['MOD_ROCKET', 6], ['MOD_ROCKET_SPLASH', 7], ['MOD_PLASMA', 8],
         ['MOD_PLASMA_SPLASH', 9], ['MOD_RAILGUN', 10], ['MOD_LIGHTNING', 11], ['MOD_BFG', 12],
         ['MOD_BFG_SPLASH', 13], ['MOD_WATER', 14], ['MOD_SLIME', 15], ['MOD_LAVA', 16], ['MOD_CRUSH', 17],
         ['MOD_TELEFRAG', 18], ['MOD_FALLING', 19], ['MOD_SUICIDE', 20], ['MOD_TARGET_LASER', 21],
         ['MOD_TRIGGER_HURT', 22], ['MISSIONPACK', 23], ['MOD_NAIL', 24], ['MOD_CHAINGUN', 25],
         ['MOD_PROXIMITY_MINE', 26], ['MOD_KAMIKAZE', 27], ['MOD_JUICED', 28], ['MOD_GRAPPLE', 29]]
      end

      def verify_killed(killed)
        if killed.empty?
          { player1: 0, player2: 0, weapon: 0 }
        else
          { player1: killed[1].to_i, player2: killed[2].to_i, weapon: killed[3].to_i }
        end
      end

      def kills_all_by_game
        util.filter_by_game(find_all_kills)
      end

      def find_all_kills
        util.get_indexes_by_string('Kill:')
      end
    end
  end
end
