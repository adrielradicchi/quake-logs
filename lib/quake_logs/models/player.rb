# frozen_string_literal: true

module QuakeLogs
  module Models
    # Player
    # This class to save a player data
    class Player
      attr_accessor :id, :name

      def initialize(id, name)
        @id = id
        @name = name
      end
    end
  end
end
