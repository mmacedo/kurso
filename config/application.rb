require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Kurso
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    config.i18n.default_locale = :eo

    # Precompile additional assets.
    # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
    # Kopiita ĉi tie (el production.rb) ĝis afero fermas: https://github.com/rails/sprockets-rails/pull/36
    # .swf el Sound Manager 2
    config.assets.precompile += %w(swf/soundmanager2.swf
                                   swf/soundmanager2.swf
                                   swf/soundmanager2_flash9.swf
                                   swf/soundmanager2_flash9_debug.swf)
    # .png kaj .gif el 360-gradoj ludanto
    config.assets.precompile += %w(360-button-pause.png
                                   360-button-pause-light.png
                                   360-button-play.png
                                   360-button-play-light.png
                                   icon_loading_spinner.gif)
  end
end
