#This will update events using sidekiq
require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_client do |config|
	config.redis = { url: "redis://redistogo:716332eefed35759c634713605c23a05@barreleye.redistogo.com:11658/" }
end

Sidekiq.configure_server do |config|
	config.redis = {url: "redis://redistogo:716332eefed35759c634713605c23a05@barreleye.redistogo.com:11658/"}
end

class UpdateEventsWorker
	include Sidekiq::Worker

	def perform
		puts "************************************************"
		puts "Updating events with 'rails db:seed'..."
		`rails db:seed`
		puts "Done!"
		puts "************************************************"
	end

	def stop
		Sidekiq::Cron::Job.destroy_all!
	end

end

Sidekiq::Cron::Job.create(name: 'Update Brandeis Events - every 6 hours', cron: '0 */6 * * *', class: 'UpdateEventsWorker')
