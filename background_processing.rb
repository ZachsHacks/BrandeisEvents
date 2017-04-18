#This will update events using sidekiq
require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_client do |config|
	config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
	config.redis = {db: 1}
end

class UpdateEventsWorker
	include Sidekiq::Worker

	def perform
		puts "************************************************"
		puts "Updating events with 'rails db:seed'..."
		system("rake db:setup")
		puts "Done!"
		puts "************************************************"
	end

	def stop
		Sidekiq::Cron::Job.destroy_all!
	end

end

Sidekiq::Cron::Job.create(name: 'Update Brandeis Events - every 5 minutes', cron: '*/5 * * * *', class: 'UpdateEventsWorker')
