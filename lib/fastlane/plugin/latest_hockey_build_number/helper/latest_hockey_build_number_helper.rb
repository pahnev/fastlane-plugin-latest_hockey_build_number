module Fastlane
  module Helper
    class LatestHockeyBuildNumberHelper
      # class methods that you define here become available in your action
      # as `Helper::LatestHockeyBuildNumberHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the latest_hockey_build_number plugin helper!")
      end
    end
  end
end
