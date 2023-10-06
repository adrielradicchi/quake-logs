# frozen_string_literal: true

module QuakeLogs
  module Models
    # Kill
    # This class to save kills by means
    class Kill
      attr_accessor :kill_by_means

      def initialize(kill_by_means)
        @kill_by_means = kill_by_means
      end

      def to_json(*args)
        {
          'kill_by_means' => kill_by_means.to_h
        }.to_json(*args)
      end
    end
  end
end
