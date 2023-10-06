# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe QuakeLogs::Modules::Util do
  let(:log) { QuakeLogs::Business::Log.new }
  let(:log_file) { log.open_log('spec/games/test.log') }
  let(:array_log) { log.read_log(log_file) }
  let(:util) { described_class.new(array_log) }

  describe 'get_indexes_by_string' do
    let(:get_indexes_by_string) { util.get_indexes_by_string('Kill:') }

    it { get_indexes_by_string.should be_instance_of Array }
    it { get_indexes_by_string.should_not be_empty }
    it { get_indexes_by_string[1].should eql 20 }
  end

  describe 'filter_by_game' do
    let(:filter_by_game) { util.filter_by_game(util.get_indexes_by_string('ClientUserinfoChanged:')) }

    it { filter_by_game.should be_instance_of Array }
    it { filter_by_game.should_not be_empty }
    it { filter_by_game[0].should_not be_empty }
    it { filter_by_game[1][0].should eql 12 }
  end

  describe 'find_all_start_games' do
    let(:find_all_start_games) { util.find_all_start_games }

    it { find_all_start_games.should be_instance_of Array }
    it { find_all_start_games.should_not be_nil }
    it { find_all_start_games.should eql [1, 10, 97] }
  end

  describe 'find_all_end_games' do
    let(:find_all_end_games) { util.find_all_end_games }

    it { find_all_end_games.should be_instance_of Array }
    it { find_all_end_games.should_not be_empty }
    it { find_all_end_games.should eql [9, 96, 157] }
  end
end
