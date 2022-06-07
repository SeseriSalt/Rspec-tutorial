require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Projects
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    #RSpecを標準のテストにするやつ
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false, #ビュースペックを作成しない→代わりにシステムスペックでUIをテスト
                       helper_specs: false, #ヘルパーファイル用のスペックを作成しない
                       routing_specs: false #ルーティンぐのスペックを作成しない
      g.factory_bot false
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
