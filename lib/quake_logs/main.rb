# frozen_string_literal: true

require_relative './business/log'
require_relative './business/killers'
require_relative './business/players'
require_relative './models/game'
require_relative './models/kill'
require_relative './models/player'

require 'json'

module QuakeLogs
  # Main
  # This class contains the logic generation of return
  class Main
    attr_accessor :array_log, :kills_obj, :players_obj

    def initialize(path_with_file)
      log = QuakeLogs::Business::Log.new
      file = log.open_log(path_with_file)
      @array_log = log.read_log(file)
      @kills_obj = QuakeLogs::Business::Killers.new(@array_log)
      @players_obj = QuakeLogs::Business::Players.new(@array_log)
    end

    def build_game
      JSON.pretty_generate(build_games_struct.to_h)
    end

    def report_players_ranking
      JSON.pretty_generate(sort_players_ranking.to_h)
    end

    def report_kills_means
      JSON.pretty_generate(kills_by_means.to_h)
    end

    private

    def kills_by_means
      kills_obj.kills_by_game_and_means.map.with_index do |kill_by_means, index|
        ["game_#{index + 1}", QuakeLogs::Models::Kill.new(kill_by_means)]
      end
    end

    def sort_players_ranking
      build_games_struct.map do |games|
        kills = games.last.kills.sort { |kills1, kills2| kills2.last <=> kills1.last }
        games.last.kills = kills

        games
      end
    end

    def build_games_struct
      kills_players_by_game = kills_obj.kills_by_game
      players_obj.build_players.map.with_index do |players, index|
        players_name = players_obj.players_name_by_game(players)
        total_kills = kills_obj.count_all_killed_by_game(kills_players_by_game[index])
        kills = build_players_count_killed(players, kills_players_by_game[index])
        ["game_#{index + 1}", Models::Game.new(total_kills, players_name, kills)]
      end
    end

    def build_players_count_killed(players, kills)
      players.map do |player|
        count_kills_players = kills_obj.count_killed_by_player(kills, player.id)
        count_world_kills = kills_obj.count_world_killed_by_player(kills, player.id)
        count = count_kills_players - count_world_kills
        [player.name.to_s, count]
      end
    end
  end
end
