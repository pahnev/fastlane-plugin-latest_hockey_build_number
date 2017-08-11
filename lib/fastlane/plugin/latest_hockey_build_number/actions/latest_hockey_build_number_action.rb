require 'json'
require 'net/http'

module Fastlane
  module Actions
    class LatestHockeyBuildNumberAction < Action
      def self.run(config)
        host_uri = URI.parse('https://rink.hockeyapp.net')
        http = Net::HTTP.new(host_uri.host, host_uri.port)
        http.use_ssl = true
        list_request = Net::HTTP::Get.new('/api/2/apps')
        list_request['X-HockeyAppToken'] = config[:api_token]
        list_response = http.request(list_request)
        app_list = JSON.parse(list_response.body)['apps']

        apps = app_list.select { |app| app['platform'] == 'iOS' && app['bundle_identifier'] == config[:bundle_id] }

        release_type = config[:release_type]
        apps = apps.select { |app| app['release_type'] == release_type.to_i } unless release_type.nil?

        if apps.empty?
          release_type_message = release_type.nil? ? "" : " with release type #{release_type}"
          UI.error "No application with bundle id #{config[:bundle_id]}" + release_type_message
          return nil
        end

        app_identifier = apps.first['public_identifier']

        details_request = Net::HTTP::Get.new("/api/2/apps/#{app_identifier}/app_versions?page=1")
        details_request['X-HockeyAppToken'] = config[:api_token]
        details_response = http.request(details_request)

        app_details = JSON.parse(details_response.body)
        app_versions = app_details['app_versions']

        bundle_short_version = config[:bundle_short_version]
        app_versions = app_versions.select { |app_version| app_version['shortversion'] == bundle_short_version } unless bundle_short_version.nil?

        latest_build = app_versions.first

        if latest_build.nil?
          bundle_short_version_message = bundle_short_version.nil? ? "" : " for #{bundle_short_version}"
          UI.error "The app has no versions yet" + bundle_short_version_message
          return nil
        end

        return latest_build['version']
      end

      def self.description
        "Gets latest version number of the app with the bundle id from HockeyApp"
      end

      def self.authors
        ["pahnev", "FlixBus (original author)"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_token,
                                       env_name: "FL_HOCKEY_API_TOKEN",
                                       description: "API Token for Hockey Access",
                                       verify_block: proc do |value|
                                         UI.user_error!("No API token for Hockey given, pass using `api_token: 'token'`") unless value and !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :bundle_id,
                                       env_name: "FL_HOCKEY_BUNDLE_ID",
                                       description: "Bundle ID of the application",
                                       verify_block: proc do |value|
                                         UI.user_error!("No bundle ID for Hockey given, pass using `bundle_id: 'bundle id'`") unless value and !value.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :release_type,
                                     env_name: "FL_HOCKEY_RELEASE_TYPE",
                                     description: "Release type of the app: \"0\" = Beta, \"1\" = Store, \"2\" = Alpha, \"3\" = Enterprise. Used as an additional filter for the app list",
                                     optional: true),
          FastlaneCore::ConfigItem.new(key: :bundle_short_version,
                                     env_name: "FL_HOCKEY_BUNDLE_SHORT_VERSION",
                                     description: "The bundle_short_version of your application. Used as an additional filter for the version list. Caution filters short version only for 1st page resutls",
                                     optional: true)
        ]
      end

      def self.is_supported?(platform)
        [:ios].include? platform
      end
    end
  end
end
