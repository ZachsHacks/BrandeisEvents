require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CampusNow
	class Application < Rails::Application
		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.
		# Do not swallow errors in after_commit/after_rollback callbacks.
		config.active_record.raise_in_transactional_callbacks = true
		config.active_job.queue_adapter = :delayed_job
		config.exceptions_app = self.routes

		config.time_zone = 'Eastern Time (US & Canada)'
		Date::DATE_FORMATS[:default] = "%m/%d/%Y"

		config.paths.add File.join("app", "bot"), glob: File.join("**","*.rb")
		# config.active_record.default_timezone = 'Eastern Time (US & Canada)'

		# config.after_initialize do
	  #   Delayed::Job.scaler = :heroku
	  # end
	end
end
