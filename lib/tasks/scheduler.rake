desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  rails db:seed
  Rails.application.load_seed
  puts "done."
end
