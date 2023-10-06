# frozen_string_literal: true

require_relative '../models/player'
require_relative '../modules/util'

module QuakeLogs
  module Business
    # Players
    # This class contains rules about players
    class Players
      attr_accessor :array_log, :util

      def initialize(array_log)
        @array_log = array_log
        @util = QuakeLogs::Modules::Util.new(array_log)
      end

      def players_by_game
        players_all_by_game.map do |players|
          players.map { |player| build_players_by_game(player) }.uniq
        end
      end

      def sort_by_player_id
        players_by_game.map do |players|
          players.sort_by(&:id)
        end
      end

      def build_players
        remove_duplicated_players
      end

      def players_name_by_game(players)
        players.map(&:name)
      end

      private

      def remove_duplicated_players
        sort_by_player_id.map do |players|
          remove_players =
            players.select.with_index do |player, index|
              player.id == players[index + 1].id if players.length > 1 && index + 1 < players.length
            end
          verify_removed_players(players, remove_players)
        end
      end

      def build_players_by_game(player)
        id = array_log[player].split(/(\s\d+\s)/)[1].split(/\s/).last.to_i
        name = array_log[player].split('\\t').first.split('n\\').last
        QuakeLogs::Models::Player.new(id, name)
      end

      def verify_removed_players(players, remove_players)
        if remove_players.empty?
          players
        else
          players - remove_players
        end
      end

      def players_all_by_game
        util.filter_by_game(find_all_players)
      end

      def find_all_players
        util.get_indexes_by_string('ClientUserinfoChanged:')
      end
    end
  end
end
