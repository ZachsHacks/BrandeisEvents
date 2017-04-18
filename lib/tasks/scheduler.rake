desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  rails db:seed
  console("rake db:seed")
  puts "done."
end
