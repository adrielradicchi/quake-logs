# frozen_string_literal: true

require_relative '../../spec_helper'
require 'faker'

RSpec.describe QuakeLogs::Models::Kill do
  let(:weapon_name) { Faker::Games::ElderScrolls.weapon }
  let(:kills) { Faker::Number.number(digits: 3) }
  let(:instance) do
    described_class.new([[weapon_name, kills]])
  end

  describe 'validations' do
    it { instance.kill_by_means.should be_instance_of Array }
    it { instance.kill_by_means.should_not be_empty }
    it { instance.kill_by_means.should eql [[weapon_name, kills]] }
  end

  describe 'to_json' do
    let(:to_json) { instance.to_json }

    it { to_json.should be_instance_of String }
    it { to_json.should_not be_empty }
    it { to_json.should be_include weapon_name.to_s }
  end
end
