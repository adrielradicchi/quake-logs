# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe QuakeLogs::Business::Players do
  let(:log) { QuakeLogs::Business::Log.new }
  let(:log_file) { log.open_log('spec/games/test.log') }
  let(:array_log) { log.read_log(log_file) }
  let(:players) { described_class.new(array_log) }

  describe 'players_by_game' do
    let(:players_by_game) { players.players_by_game }

    it { players_by_game.should be_instance_of Array }
    it { players_by_game.should_not be_empty }
    it { players_by_game[0][0].id.should eql 2 }
    it { players_by_game[2][0].name.should eql 'Dono da Bola' }
  end

  describe 'sort_by_player_id' do
    let(:sort_by_player_id) { players.sort_by_player_id }

    it { sort_by_player_id.should be_instance_of Array }
    it { sort_by_player_id.should_not be_empty }
    it { sort_by_player_id[0][0].id.should eql 2 }
    it { sort_by_player_id[2][1].name.should eql 'Mocinha' }
  end

  describe 'build_players' do
    let(:build_players) { players.build_players }

    it { build_players.should be_instance_of Array }
    it { build_players.should_not be_empty }
    it { build_players[0][0].id.should eql 2 }
    it { build_players[2][1].name.should eql 'Isgalamido' }
  end

  describe 'players_name_by_game' do
    let(:players_name_by_game) { players.players_name_by_game(players.build_players[1]) }

    it { players_name_by_game.should be_instance_of Array }
    it { players_name_by_game.should_not be_empty }
    it { players_name_by_game[0].should eql 'Isgalamido' }
  end
end
