require_relative "boot"

require "rails/all"
require "roo"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HighSchool
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoloader = :classic
    config.enable_dependency_loading = true
    config.autoload_paths += %W(#{config.root}/lib)
    # config.active_job.queue_adapter = :delayed_job
    # I18n.default_locale = :en

    # Avoid deprecated message
    # config.i18n.enforce_available_locales = true
    # config.time_zone = ENV['TIME_ZONE'] || 'UTC'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.to_prepare do
      # Or to configure mailer layout
      #Devise::Mailer.layout "mail_layout"
    end
  end
end
