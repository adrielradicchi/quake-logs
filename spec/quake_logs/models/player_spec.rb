# frozen_string_literal: true

require_relative '../../spec_helper'
require 'faker'

RSpec.describe QuakeLogs::Models::Player do
  let(:name) { Faker::Name.name }
  let(:id) { Faker::Number.number(digits: 2) }
  let(:instance) { described_class.new(id, name) }

  describe 'validations' do
    it { instance.id.should be_instance_of Integer }
    it { instance.id.should eql id }
    it { instance.name.should_not be_empty }
    it { instance.name.should eql name }
  end
end
