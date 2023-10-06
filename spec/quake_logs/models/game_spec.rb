# frozen_string_literal: true

require_relative '../../spec_helper'
require 'faker'

RSpec.describe QuakeLogs::Models::Game do
  let(:player_name) { Faker::Name.name }
  let(:total_kills) { Faker::Number.number(digits: 3) }
  let(:kills) { Faker::Number.number(digits: 2) }
  let(:instance) do
    described_class.new(total_kills, [player_name], [[player_name, kills]])
  end

  describe 'validations' do
    it { instance.players.should eql [player_name] }
    it { instance.kills.should eql [[player_name, kills]] }
    it { instance.total_kills.should eql total_kills }
  end

  describe 'to_json' do
    let(:to_json) { instance.to_json [] }

    it { to_json.should be_instance_of String }
    it { to_json.should_not be_empty }
    it { to_json.should be_include player_name.to_s }
  end
end
