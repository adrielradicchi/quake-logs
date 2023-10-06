# frozen_string_literal: true

require 'json'

module QuakeLogs
  module Models
    # Game
    # This class to save a game data
    class Game
      attr_accessor :total_kills, :players, :kills

      def initialize(total_kills, players, kills)
        @total_kills = total_kills
        @players = players
        @kills = kills
      end

      def to_json(*args)
        {
          'total_kills' => total_kills,
          'players' => players,
          'kills' => kills.to_h
        }.to_json(*args)
      end
    end
  end
end
