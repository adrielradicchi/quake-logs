# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe QuakeLogs::Business::Log do
  let(:instance) { described_class.new }
  let(:log_files) { instance.open_log('spec/games/test.log') }

  describe '.open_log' do
    context 'when open successfully log file' do
      it { log_files.should be_instance_of File }
      it { log_files.should_not be_nil }
    end
  end

  describe '.read_file' do
    context 'when read file sucessfully log file' do
      let(:log_lines) { instance.read_log(log_files) }

      it { log_lines.should be_instance_of Array }
      it { log_lines.should_not be_empty }
    end
  end
end
