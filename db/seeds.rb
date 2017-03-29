require 'faker'
require_relative 'brandeis_event_parser'

@user_count = User.count

@data = BrandeisEventParser.new.get_data

def create_events
	# x.times do |event|
	# 	name = Faker::Name.unique.name
	# 	description = Faker::Lorem.paragraph(5)
	# 	start_time = Faker::Time.between(DateTime.now - 1, DateTime.now)
	# 	end_time  = Faker::Time.between(DateTime.now - 1, DateTime.now)
	# 	location = 	Faker::Address.city
	# 	price = rand(50)
	# 	host = rand(@user_count) + 1
	# 	Event.create(name: name, description: description, start: start_time, end: end_time, price: price, host_id: host, location: location)
	# end

	@data.each do |line|
		title = line["title"]
		description_html = line["content"]
		date_time = Time.parse(line["published"].to_s)
		relavent_link = line["gc:weblink"]
		image_id = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRCV8cQhEbPEz0yF0piMIseNgxSAKW7FOImmw7LoWS3wniHvGZW"
		Event.create(name: title, description: description_html, start: date_time, host_id: User.first.id, image_id: image_id)
	end

end

def create_host
	User.create(uid: "calender", provider: "google", first_name: "BrandeisEvents",   email: "calender@brandeis.edu", can_host: true, is_admin: false)
end

create_host
create_events
