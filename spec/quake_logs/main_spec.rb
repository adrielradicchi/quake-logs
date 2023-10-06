# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe QuakeLogs::Main do
  let(:main) { described_class.new('spec/games/test.log') }

  describe 'build_game' do
    let(:build_game) { main.build_game }

    it { build_game.should be_instance_of String }
    it { build_game.should_not be_empty }
    it { build_game.should be_include 'game_1' }
  end

  describe 'report_players_ranking' do
    let(:report_players_ranking) { main.report_players_ranking }

    it { report_players_ranking.should be_instance_of String }
    it { report_players_ranking.should_not be_empty }
    it { report_players_ranking.should be_include ' "Mocinha": 0,' }
    it { report_players_ranking.should be_include 'game_3' }
  end

  describe 'report_kills_means' do
    let(:report_kills_means) { main.report_kills_means }

    it { report_kills_means.should be_instance_of String }
    it { report_kills_means.should_not be_empty }
    it { report_kills_means.should be_include '"MOD_FALLING": 1' }
    it { report_kills_means.should be_include 'game_3' }
  end
end
