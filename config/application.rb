require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module DnTms01
  class Application < Rails::Application
    config.load_defaults 5.2
  end
end
