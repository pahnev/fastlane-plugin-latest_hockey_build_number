# latest_hockey_build_number plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-latest_hockey_build_number)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-latest_hockey_build_number`, add it to your project by running:

```bash
fastlane add_plugin latest_hockey_build_number
```

Once you've added the plugin, add the latest_hockey_build_number action to your Fastfile. Like this:

```ruby
platform :ios do
  beta do
    version_number = latest_hockey_build_number
  end
end
```


## About latest_hockey_build_number

Gets latest version number of the app with the bundle id from HockeyApp. Special thanks to  [nikolaykasyanov](https://github.com/nikolaykasyanov) who published the [gist](https://gist.github.com/nikolaykasyanov/fa9f727a2659450f49825a238546ea8b).

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

## About `fastlane`

`fastlane` is the easiest way to automate building and releasing your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
