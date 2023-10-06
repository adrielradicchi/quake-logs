# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe QuakeLogs::Business::Killers do
  let(:log) { QuakeLogs::Business::Log.new }
  let(:log_file) { log.open_log('spec/games/test.log') }
  let(:array_log) { log.read_log(log_file) }
  let(:kills_by_game) { described_class.new(array_log).kills_by_game }

  describe 'kills_by_game' do
    it { kills_by_game.should be_instance_of Array }
    it { kills_by_game.should_not be_empty }
    it { kills_by_game[1][0][:player1].should eql 1022 }
    it { kills_by_game[2][1][:player2].should eql 4 }
    it { kills_by_game[2][3][:weapon].should eql 19 }
  end

  describe 'kills_by_game_and_means' do
    let(:kills_by_game_and_means) { described_class.new(array_log).kills_by_game_and_means }

    it { kills_by_game_and_means.should be_instance_of Array }
    it { kills_by_game_and_means.should_not be_empty }
    it { kills_by_game_and_means[0].should be_empty }
    it { kills_by_game_and_means[1][0].should eql ['MOD_TRIGGER_HURT', 7] }
  end

  describe 'count_killed_by_player' do
    let(:count_killed_by_player) { described_class.new(array_log).count_killed_by_player(kills_by_game[1], 2) }

    it { count_killed_by_player.should be_instance_of Integer }
    it { count_killed_by_player.should_not be_nil }
    it { count_killed_by_player.should eql 3 }
  end

  describe 'count_world_killed_by_player' do
    let(:count_world_killed_by_player) { described_class.new(array_log).count_world_killed_by_player(kills_by_game[1], 3) }

    it { count_world_killed_by_player.should be_instance_of Integer }
    it { count_world_killed_by_player.should_not be_nil }
    it { count_world_killed_by_player.should eql 0 }
  end

  describe 'count_all_killed_by_game' do
    let(:count_all_killed_by_game) { described_class.new(array_log).count_all_killed_by_game(kills_by_game[1]) }

    it { count_all_killed_by_game.should be_instance_of Integer }
    it { count_all_killed_by_game.should_not be_nil }
    it { count_all_killed_by_game.should be_positive }
  end

  describe 'count_kills_by_means' do
    let(:count_kills_by_means) { described_class.new(array_log).count_kills_by_means(kills_by_game[1], 22) }

    it { count_kills_by_means.should be_instance_of Integer }
    it { count_kills_by_means.should_not be_nil }
    it { count_kills_by_means.should be_positive }
  end
end
