#This will update events using sidekiq
require 'sidekiq'


Sidekiq.configure_client do |config|
	config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
	config.redis = {db: 1}
end

class UpdateEventsWorker
	include Sidekiq::Worker

	def perform(complexity)
		puts "Updating events..."
		`rails db:seed`
		puts "Done!"
	end
end
