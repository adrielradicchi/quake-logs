# frozen_string_literal: true

module QuakeLogs
  module Business
    # Log
    # Class for open and read a logs of quake games.
    class Log
      def open_log(path_with_file)
        File.open(path_with_file)
      end

      def read_log(file)
        file.readlines.map(&:chomp)
      end
    end
  end
end
