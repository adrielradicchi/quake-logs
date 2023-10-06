# frozen_string_literal: true

module QuakeLogs
  module Modules
    # Utils
    # This class to server another classes
    class Util
      attr_accessor :array_log

      def initialize(array_log)
        @array_log = array_log
      end

      def get_indexes_by_string(text)
        array_indexes = []
        array_log.select.with_index { |element, index| array_indexes.append index if element.include? text }
        array_indexes
      end

      def filter_by_game(filter_array)
        all_end_games = find_all_end_games
        filter_by_game = []

        find_all_start_games.map.with_index do |start, index|
          filter_by_game.append(filter_array.select { |filter| start < filter && all_end_games[index] > filter })
        end

        filter_by_game
      end

      def find_all_start_games
        get_indexes_by_string('InitGame:')
      end

      def find_all_end_games
        end_games = get_indexes_by_string('------------------------------------------------------------')
        end_games.delete_if.with_index { |del, index| del + 1 == end_games[index + 1] }
        end_games.delete_at(0)

        end_games
      end
    end
  end
end
